## Louisiana and New Orleans geographic data

A collection of cleaned geographic data for New Orleans and Louisiana, along with a fully scripted data-cleaning process using command line tools.

__Table of contents__

* [What's included](#whats-included)
* [Data release schedule](#data-release-schedule)
* [Known problems](#known-problems)
* [Future releases](#future-releases)
* [Contributing to this project](#contributing-to-this-project)
* [Setup for development](#setup-for-development)
* [Contact](#contact)
* [License](#license)

## What's included

All files that are ready for use are stored in the `exports` directory. Each geography includes a full-sized version with all original metadata, as well as a simplified version (using the suffix `-simplified`) with less accurate boundaries that is smaller in size than the original and only includes the relevant metadata. The simplified versions are more suitable for web applications because of their smaller file sizes.

All files are available in the ESRI Shapefile (.shp), GeoJSON (.json) and TopoJSON (.json) file formats.

|               |Geography                                                                 |Shapefile                             |GeoJSON                                   |TopoJSON                                   |
|---------------|--------------------------------------------------------------------------|-------------------------------------:|-----------------------------------------:|------------------------------------------:|
|__New Orleans__|City limits                                                               |[ 43   kB](exports/shp/parishes/)     |[ 72   kB](exports/geojson/parishes/)     |[ 21   kB](exports/topojson/parishes/)     |
|               |City limits (simplified)                                                  |[  5   kB](exports/shp/parishes/)     |[  9   kB](exports/geojson/parishes/)     |[  3   kB](exports/topojson/parishes/)     |
|               |City limits, without Lake Pontchartrain                                   |[116   kB](exports/shp/parishes/)     |[195   kB](exports/geojson/parishes/)     |[ 49   kB](exports/topojson/parishes/)     |
|               |City limits, without Lake Pontchartrain (simplified)                      |[ 10   kB](exports/shp/parishes/)     |[ 17   kB](exports/geojson/parishes/)     |[  6   kB](exports/topojson/parishes/)     |
|               |City limits, without Lake Pontchartrain and Mississippi River             |[131   kB](exports/shp/parishes/)     |[219   kB](exports/geojson/parishes/)     |[ 55   kB](exports/topojson/parishes/)     |
|               |City limits, without Lake Pontchartrain and Mississippi River (simplified)|[ 11   kB](exports/shp/parishes/)     |[ 18   kB](exports/geojson/parishes/)     |[  6   kB](exports/topojson/parishes/)     |
|               |Neighborhoods                                                             |[239   kB](exports/shp/neighborhoods/)|[658   kB](exports/geojson/neighborhoods/)|[ 95   kB](exports/topojson/neighborhoods/)|
|               |Neighborhoods (simplified)                                                |[ 45   kB](exports/shp/neighborhoods/)|[121   kB](exports/geojson/neighborhoods/)|[ 30   kB](exports/topojson/neighborhoods/)|
|               |Voting precincts                                                          |[545   kB](exports/shp/precincts/)    |[  1.6 MB](exports/geojson/precincts/)    |[265   kB](exports/topojson/precincts/)    |
|               |Voting precincts (simplified)                                             |[ 70   kB](exports/shp/precincts/)    |[192   kB](exports/geojson/precincts/)    |[ 78   kB](exports/topojson/precincts/)    |
|__Louisiana__  |Parishes                                                                  |[  7.5 MB](exports/shp/parishes/)     |[ 12.5 MB](exports/geojson/parishes/)     |[  1.3 MB](exports/topojson/parishes/)     |
|               |Parishes (simplified)                                                     |[626   kB](exports/shp/parishes/)     |[  1.1 MB](exports/geojson/parishes/)     |[308   kB](exports/topojson/parishes/)     |
|               |Voting precincts*                                                         |[ 31.4 MB](exports/shp/precincts/)    |[ 89.6 MB](exports/geojson/precincts/)    |[  5.9 MB](exports/topojson/precincts/)    |
|               |Voting precincts (simplified)                                             |[  3.6 MB](exports/shp/precincts/)    |[ 10.1 MB](exports/geojson/precincts/)    |[  2.2 MB](exports/topojson/precincts/)    |
|               |BESE districts                                                            |[  2.3 MB](exports/shp/bese/)         |[  6.3 MB](exports/geojson/bese/)         |[446   kB](exports/topojson/bese/)         |
|               |BESE districts (simplified)                                               |[260   kB](exports/shp/bese/)         |[728   kB](exports/geojson/bese/)         |[ 91   kB](exports/topojson/bese/)         |
|__Water__      |Mississippi River                                                         |[968   kB](exports/shp/water/)        |[  1.5 MB](exports/geojson/water/)        |[242   kB](exports/topojson/water/)        |
|               |Mississippi River (simplified)                                            |[ 73   kB](exports/shp/water/)        |[123   kB](exports/geojson/water/)        |[ 36   kB](exports/topojson/water/)        |
|               |Lake Pontchartrain                                                        |[203   kB](exports/shp/water/)        |[340   kB](exports/geojson/water/)        |[ 78   kB](exports/topojson/water/)        |
|               |Lake Pontchartrain (simplified)                                           |[ 13   kB](exports/shp/water/)        |[ 22   kB](exports/geojson/water/)        |[  7   kB](exports/topojson/water/)        |
|               |Gulf of Mexico                                                            |[  4.4 MB](exports/shp/water/)        |[  7.4 MB](exports/geojson/water/)        |[  1.1 MB](exports/topojson/water/)        |
|               |Gulf of Mexico (simplified)                                               |[667   kB](exports/shp/water/)        |[  1.1 MB](exports/geojson/water/)        |[326   kB](exports/topojson/water/)        |

*__Note:__ The Louisiana precincts file from the House of Representatives is almost always out of date, so only use this file for historical data. This would not be suitable for an election night live data feed because the parcel shapes won't match.

## Data release schedule

|               |Data                    |Last release|Next expected release|
|---------------|------------------------|-----------:|--------------------:|
|__New Orleans__|Neighborhoods           |8/25/2015   |Uncertain            |
|               |Precincts               |10/2/2015   |Uncertain            |
|__Louisiana__  |Parishes                |11/10/2010  |11/10/2020           |
|               |Precincts (statewide)   |Uncertain   |Uncertain            |
|__Water__      |Mississippi River       |8/12/2015   |8/12/2016            |
|               |Lake Pontchartrain      |8/12/2015   |8/12/2016            |
|               |Gulf of Mexico          |8/12/2015   |8/12/2016            |

## Known problems

Statewide precincts file is often out of date for at least some parishes. Some parishes update their precincts faster than the state can release new precinct files. The state does not release a given elections' precincts shapefile until after the election. This file is mostly created for historical data analysis, and should not be assumed to be presently accurate. Don't use this file for live election night coverage!

## Future releases

See the Issues tagged "data-suggestion" for plans for the future. Comment on those issues if you'd rather see some sooner than others.

## Contributing to this project

See [`CONTRIBUTING`](CONTRIBUTING) for the full details about how you can contribute to this project. Here are the basics:

Report bugs, ask questions and suggest features on the [Issues](https://github.com/TheLens/geographic-data/issues) page. If you aren't sure whether you should submit a pull request or not, just do it. I'm not picky and would much rather receive some sort of help and have to make adjustments than receive no help at all.

## Setup for development

All cleaning is done using the command-line tools `ogr2ogr` and `topojson`. A single Makefile scripts each step, which makes use of other Unix utilities.

#### Installation

If possible, use a package manager such as [Homebrew](http://brew.sh/) for Mac or [apt-get](http://manpages.ubuntu.com/manpages/raring/man8/apt-get.8.html) for Linux to make your life easier.

__ogr2ogr__

Linux:

```bash
apt-get install gdal-bin

# May need to run as super user.
# If you get a permissions error, try running the following:
# sudo apt-get install gdal-bin
```

Mac: `brew install gdal`

__topojson__

Relies on node.js. See below for how to install node.js.

Linux: `npm install -g topojson`

Mac: `npm install -g topojson`

__node.js__

Linux: `apt-get install nodejs`

Mac: `brew install node`

## Contact

This repo is maintained by [Thomas Thoren](https://github.com/ThomasThoren). Please contact tthoren@thelensnola.org with any questions.

###License

MIT. See [`LICENSE`](LICENSE) for full information.
