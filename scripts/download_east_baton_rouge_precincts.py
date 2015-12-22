
'''Downloads East Baton Rouge Parish precincts from ArcGIS server.'''

import sys
import arcgis
import json


def main(destination_file='east-baton-rouge-precincts.json'):
    '''doc'''

    source = "http://maps.brgov.com/gis/rest/services/" + \
        "Governmental_Units/Voting_Precinct/MapServer/"
    service = arcgis.ArcGIS(source, object_id_field='')
    layer_id = 0
    shapes = service.get(layer_id)

    with open(destination_file, 'w') as fl:
        fl.write(json.dumps(shapes))

if __name__ == '__main__':
    try:
        download_directory = sys.argv[1]
        main(destination_file=download_directory)
    except IndexError:
        main()
