using System.Linq;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace PomeranianADogSaid2Renew.PickleSteps
{
    /// <summary>
    /// Reads of the live defs, after every patch of the mod list under test has been applied. The
    /// offline suite reads the XML before the game touches it; this reads what the game kept: the
    /// operations a race is actually offered once A Dog Said 2 has copied its categories.
    /// </summary>
    [PickleSteps]
    public class RecipeSteps
    {
        private static ThingDef Race(PickleContext ctx, string defName)
        {
            var def = DefDatabase<ThingDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no ThingDef named '{defName}' is loaded in this pass");
            return def;
        }

        [Then("Pomeranian Patch Renew the race {string} offers the recipe {string}")]
        public void Offers(PickleContext ctx, string race, string recipe)
        {
            var offered = Race(ctx, race).AllRecipes.Select(r => r.defName).ToList();
            ctx.Assert(offered.Contains(recipe), $"{race} offers {offered.Count} recipes and {recipe} is not one of them");
        }

        [Then("Pomeranian Patch Renew the race {string} does not offer the recipe {string}")]
        public void DoesNotOffer(PickleContext ctx, string race, string recipe)
        {
            var offered = Race(ctx, race).AllRecipes.Select(r => r.defName).ToList();
            ctx.Assert(!offered.Contains(recipe), $"{race} offers {recipe}");
        }
    }
}
