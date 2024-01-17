export function getIntArray(coords: { x: number; y: number }[]) {
  return coords.reduce((prev: number[], { x, y }) => [...prev, x, y], []);
}

export function getBlueprint(width: number, height: number) {
  //write a function that takes in width and height and returns a blueprint
  //that is width x height
  const blueprint = [];
  for (let x = 0; x < width; x++) {
    for (let y = 0; y < height; y++) {
      blueprint.push({ x: -x, y: -y });
    }
  }
  return getIntArray(blueprint);
}
