"""
topo2geojson.py
Convert topojson to geojson

Example Usage:
  python topo2geojson.py data.topojson data.geojson


The topojson tested here was created using the mbostock topojson CLI
created with --spherical coords and --properties turned on

Author: Matthew Perry (http://github.com/perrygeo)
Thanks to @sgillies for the topojson geometry logic
requires:
  https://github.com/sgillies/topojson/blob/master/topojson.py

Next steps: how can this be generalized to a robust CLI converter?
"""
import json
import sys
from topojson import geometry
from shapely.geometry import asShape

topojson_path = sys.argv[1]
geojson_path = sys.argv[2]

with open(topojson_path, 'r') as fh:
    f = fh.read()
    topology = json.loads(f)

# file can be renamed, the first 'object' is more reliable
layername = topology['objects'].keys()[0]

features = topology['objects'][layername]['geometries']
scale = topology['transform']['scale']
trans = topology['transform']['translate']

with open(geojson_path, 'w') as dest:
    fc = {'type': "FeatureCollection", 'features': []}

    for id, tf in enumerate(features):
        f = {'id': id, 'type': "Feature"}
        f['properties'] = tf['properties'].copy()

        # print tf

        geommap = geometry(tf, topology['arcs'], scale, trans)

        geom = asShape(geommap).buffer(0)
        assert geom.is_valid
        f['geometry'] = geom.__geo_interface__

        fc['features'].append(f)

    dest.write(json.dumps(fc))
