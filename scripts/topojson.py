""" topojson.py

Functions that extract GeoJSON-ish data structures from TopoJSON
(https://github.com/mbostock/topojson) topology data.

Author: Sean Gillies (https://github.com/sgillies)
"""

from itertools import chain

def rel2abs(arc, scale=None, translate=None):
    """Yields absolute coordinate tuples from a delta-encoded arc.

    If either the scale or translate parameter evaluate to False, yield the
    arc coordinates with no transformation."""
    if scale and translate:
        a, b = 0, 0
        for ax, bx in arc:
            a += ax
            b += bx
            yield scale[0]*a + translate[0], scale[1]*b + translate[1]
    else:
        for x, y in arc:
            yield x, y

def coordinates(arcs, topology_arcs, scale=None, translate=None):
    """Return GeoJSON coordinates for the sequence(s) of arcs.

    The arcs parameter may be a sequence of ints, each the index of a
    coordinate sequence within topology_arcs
    within the entire topology -- describing a line string, a sequence of
    such sequences -- describing a polygon, or a sequence of polygon arcs.

    The topology_arcs parameter is a list of the shared, absolute or
    delta-encoded arcs in the dataset.

    The scale and translate parameters are used to convert from delta-encoded
    to absolute coordinates. They are 2-tuples and are usually provided by
    a TopoJSON dataset.
    """
    if isinstance(arcs[0], int):
        coords = [
            list(
                rel2abs(
                    topology_arcs[arc if arc >= 0 else ~arc],
                    scale,
                    translate )
                 )[::arc >= 0 or -1][i > 0:] \
            for i, arc in enumerate(arcs) ]
        return list(chain.from_iterable(coords))
    elif isinstance(arcs[0], (list, tuple)):
        return list(
            coordinates(arc, topology_arcs, scale, translate) for arc in arcs)
    else:
        raise ValueError("Invalid input %s", arcs)

def geometry(obj, topology_arcs, scale=None, translate=None):
    """Converts a topology object to a geometry object.

    The topology object is a dict with 'type' and 'arcs' items, such as
    {'type': "LineString", 'arcs': [0, 1, 2]}.

    See the coordinates() function for a description of the other three
    parameters.
    """
    return {
        "type": obj['type'],
        "coordinates": coordinates(
            obj['arcs'], topology_arcs, scale, translate )}


if __name__ == "__main__":

    # An example.

    import json
    import pprint

    data = """{
    "arcs": [
      [[0, 0], [1, 0]],
      [[1.0, 0.0], [0.0, 1.0]],
      [[0.0, 1.0], [0.0, 0.0]],
      [[1.0, 0.0], [1.0, 1.0]],
      [[1.0, 1.0], [0.0, 1.0]]
      ],
    "transform": {
      "scale": [0.035896033450880604, 0.005251163636665131],
      "translate": [-179.14350338367416, 18.906117143691233]
    },
    "objects": [
      {"type": "Polygon", "arcs": [[0, 1, 2]]},
      {"type": "Polygon", "arcs": [[3, 4, 1]]}
      ]
    }"""

    topology = json.loads(data)
    scale = topology['transform']['scale']
    translate = topology['transform']['translate']

    p = geometry({'type': "LineString", 'arcs': [0]}, topology['arcs'])
    pprint.pprint(p)

    q = geometry({'type': "LineString", 'arcs': [0, 1]}, topology['arcs'])
    pprint.pprint(q)

    r = geometry(topology['objects'][0], topology['arcs'])
    pprint.pprint(r)

    s = geometry(topology['objects'][1], topology['arcs'], scale, translate)
    pprint.pprint(s)
