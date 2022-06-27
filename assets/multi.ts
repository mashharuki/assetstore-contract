import { createAsset } from "./createAsset";

const misc = [{
  name: "Done",
  parts: [{
    mask: "", color: "",
    body: "M2 2h15v15h-15z",
  },{
    mask: "", color: "yellow",
    body: "M5 5h15v15h-15z",
  },{
    mask: "", color: "blue",
    body: "M7 7h15v15h-15z",
  },{
    mask: "", color: "red",
    body: "M9 9h15v15h-15z",
  }]
}];

export const multiAssets = misc.map(asset => {
  return createAsset(asset, "Misc.", "Standard");
});