## Louisiana and New Orleans geographic data

A collection of geographic data for New Orleans and Louisiana, with a fully scripted data-cleaning process.

__Table of contents__

* [What's included](#whats-included)
* [Future releases](#future-releases)
* [Contributing to this project](#contributing-to-this-project)
* [Setup for development](#setup-for-development)
* [Contact](#contact)
* [License](#license)

## What's included

All files that are ready for use are stored in the `exports` directory. Each geography includes a full-sized version with all original metadata, as well as a simplified version (using the suffix `-simplified`) with less accurate boundaries that is smaller in size than the original and only includes the relevant metadata. The simplified versions are more suitable for web applications because of their smaller file sizes.

All files are available in the ESRI Shapefile (.shp), GeoJSON (.json) and TopoJSON (.json) file formats.

Click the links below to see previews of each geography.

__Municipal districts__

* [French Quarter Economic Development District]
* [Neighborhods]
* [OPSB]
* [OPBS w/ precincts]

__Parishes__

* [Parishes]

__Precincts*__

* [All parishes*]
* [Caddo Parish]
* [East Baton Rouge Parish]
* [Jefferson Parish]
* [Lafayette Parish]
* [Orleans Parish]
* [St. Tammany Parish]

__Property__

* [Buildings (OpenStreetMap)]
* [Parcels]

__State districts__

* [BESE]
* [Congress]
* [House]
* [Senate]

__Water__

* [Black Bayou]
* [Caddo Lake]
* [Cross Lake]
* [Gulf of Mexico]
* [Lake Cataouatche]
* [Lake Pontchartrain]
* [Lake Salvador]
* [Little Lake]
* [Mississippi River]
* [The Pen]
* [Red River]
* [Turtle Bay]

*__Note:__ Precincts can change many times per year, so the accuracy of these files are usually only good for a few months. Always double-check with the appropriate parish offices before using the data to make sure that the parish's voting precincts have not changed recently. The statewide file comes from the House of Representatives is almost always out of date, so only use this file for historical data. This would not be suitable for an election night live data feed because the parcel shapes won't match.

## Future releases

See the [Issues tagged "data-suggestion"][Data suggestions issues] for plans for the future. Comment on those issues if you'd rather see some sooner than others.

## Contributing to this project

See [`CONTRIBUTING`](CONTRIBUTING) for the full details about how you can contribute to this project. Here are the basics:

Report bugs, ask questions and suggest features on the [Issues](https://github.com/TheLens/geographic-data/issues) page. If you aren't sure whether you should submit a pull request or not, just do it. I'm not picky and would much rather receive some sort of help and have to make adjustments than receive no help at all.

## Setup for development

Most cleaning is done using the command-line tools `ogr2ogr` and `topojson`, as well as some use of [Mapshaper], PostGIS and Python. A single Makefile scripts each step, which makes use of Unix utilities.

#### Installation

If possible, use a package manager such as [Homebrew](http://brew.sh/) for Mac or [apt-get](http://manpages.ubuntu.com/manpages/raring/man8/apt-get.8.html) for Linux to make your life easier.

__ogr2ogr__

Linux:

```bash
apt-get install gdal-bin

# If you get a permissions error, try running as super user:
sudo apt-get install gdal-bin
```

Mac:

```bash
brew install gdal
```

__node.js__

Linux:

```bash
apt-get install nodejs
```

Mac:

```bash
brew install node
```

__topojson__

Relies on node.js.

Linux and Mac:

```bash
npm install -g topojson
```

## Contact

This repo is maintained by [Thomas Thoren](https://github.com/ThomasThoren). Please contact tthoren@thelensnola.org with any questions.

### License

MIT. See [`LICENSE`](LICENSE) for full information.

[French Quarter Economic Development District]: exports/topojson/municipal-districts/orleans/economic/french-quarter-econ-dev-dist-simplified.json
[Neighborhods]: exports/topojson/municipal-districts/orleans/neighborhoods/new-orleans-simplified.json
[OPSB]: exports/topojson/municipal-districts/orleans/opsb/opsb-simplified.json
[OPBS w/ precincts]: exports/topojson/municipal-districts/orleans/opsb/opsb-simplified.json

[Parishes]: exports/topojson/parishes/parishes-simplified.json

[All parishes*]: exports/topojson/precincts/state/louisiana-simplified.json
[Caddo Parish]: exports/topojson/precincts/parish/caddo-simplified.json
[East Baton Rouge Parish]: exports/topojson/precincts/parish/east-baton-rouge-simplified.json
[Jefferson Parish]: exports/topojson/precincts/parish/jefferson-simplified.json
[Lafayette Parish]: exports/topojson/precincts/parish/lafayette-simplified.json
[Orleans Parish]: exports/topojson/precincts/parish/orleans-simplified.json
[St. Tammany Parish]: exports/topojson/precincts/parish/st-tammany-simplified.json

[Buildings (OpenStreetMap)]: exports/topojson/property/buildings/la-osm-fullsize.json
[Parcels]: exports/topojson/property/parcels/new-orleans-fullsize.json

[BESE]: exports/topojson/state-districts/bese/bese-simplified.json
[Congress]: exports/topojson/state-districts/congress/congress-simplified.json
[House]: exports/topojson/state-districts/legislature/house-simplified.json
[Senate]: exports/topojson/state-districts/legislature/senate-simplified.json

[Black Bayou]: exports/topojson/water/black-bayou-simplified.json
[Caddo Lake]: exports/topojson/water/caddo-lake-simplified.json
[Cross Lake]: exports/topojson/water/cross-lake-simplified.json
[Gulf of Mexico]: exports/topojson/water/gulf-of-mexico-simplified.json
[Lake Cataouatche]: exports/topojson/water/lake-cataouatche-simplified.json
[Lake Pontchartrain]: exports/topojson/water/lake-pontchartrain-simplified.json
[Lake Salvador]: exports/topojson/water/lake-salvador-simplified.json
[Little Lake]: exports/topojson/water/little-lake-simplified.json
[Mississippi River]: exports/topojson/water/mississippi-river-simplified.json
[The Pen]: exports/topojson/water/the-pen-simplified.json
[Red River]: exports/topojson/water/red-river-simplified.json
[Turtle Bay]: exports/topojson/water/turtle-bay-simplified.json

[Data suggestions issues]: https://github.com/TheLens/geographic-data/labels/data-suggestion
[Mapshaper]: https://github.com/mbloch/mapshaper
