
.SECONDARY:

.PHONY: bese fq_economic_development_district help neighborhoods opsb parishes precincts water

help:
	@echo There is no default command. Choose from these commands:
	@echo '  bese                             -- Creates files for Board of Elementary and Secondary Education districts.'
	@echo '  fq_economic_development_district -- Creates files for French Quarter Economic Development District.'
	@echo '  help                             -- Show available commands.'
	@echo '  neighborhoods                    -- Creates neighborhood files (Orleans Parish).'
	@echo '  opsb                             -- Creates files for Orleans Parish School Board districts.'
	@echo '  parishes                         -- Creates parish files (statewide and Orleans Parish).'
	@echo '  precincts                        -- Creates precinct files (Orleans Parish).'
	@echo '  water                            -- Creates water files (Gulf of Mexico, Lake Pontchartrain and Mississippi River).'

all: water \
	parishes \
	precincts \
	neighborhoods \
	bese \
	fq_economic_development_district \
	opsb

###########################################
#                                         #
#  Orleans Parish School Board districts  #
#                                         #
###########################################

# Download OPSB .zip files
zip/opsb/precinct-5-8-lakeside.zip:
	@# Hand-made file
	@mkdir -p $(dir $@)
	@curl -sS -o $@.download 'https://s3-us-west-2.amazonaws.com/projects.thelensnola.org/geographic-data/hand-made/opsb/$(notdir $@)'
	@mv $@.download $@
zip/opsb/precinct-5-8-riverside.zip:
	@# Hand-made file
	@mkdir -p $(dir $@)
	@curl -sS -o $@.download 'https://s3-us-west-2.amazonaws.com/projects.thelensnola.org/geographic-data/hand-made/opsb/$(notdir $@)'
	@mv $@.download $@
zip/opsb/precinct-7-12-lakeside.zip:
	@# Hand-made file
	@mkdir -p $(dir $@)
	@curl -sS -o $@.download 'https://s3-us-west-2.amazonaws.com/projects.thelensnola.org/geographic-data/hand-made/opsb/$(notdir $@)'
	@mv $@.download $@
zip/opsb/precinct-7-12-riverside.zip:
	@# Hand-made file
	@mkdir -p $(dir $@)
	@curl -sS -o $@.download 'https://s3-us-west-2.amazonaws.com/projects.thelensnola.org/geographic-data/hand-made/opsb/$(notdir $@)'
	@mv $@.download $@

# Unzip data
shp/opsb/precinct-5-8-lakeside.shp: zip/opsb/precinct-5-8-lakeside.zip
	@mkdir -p $(dir $@)
	@unzip -q -o -d $(dir $@) $<
shp/opsb/precinct-5-8-riverside.shp: zip/opsb/precinct-5-8-riverside.zip
	@mkdir -p $(dir $@)
	@unzip -q -o -d $(dir $@) $<
shp/opsb/precinct-7-12-lakeside.shp: zip/opsb/precinct-7-12-lakeside.zip
	@mkdir -p $(dir $@)
	@unzip -q -o -d $(dir $@) $<
shp/opsb/precinct-7-12-riverside.shp: zip/opsb/precinct-7-12-riverside.zip
	@mkdir -p $(dir $@)
	@unzip -q -o -d $(dir $@) $<

exports/shp/opsb/opsb-district-1-precincts.shp: exports/shp/precincts/new-orleans.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-where 'PRECINCTID = "9-1" OR \
				PRECINCTID = "9-3" OR \
				PRECINCTID = "9-4" OR \
				PRECINCTID = "9-5" OR \
				PRECINCTID = "9-6" OR \
				PRECINCTID = "9-7" OR \
				PRECINCTID = "9-8" OR \
				PRECINCTID = "9-32" OR \
				PRECINCTID = "9-35" OR \
				PRECINCTID = "9-35A" OR \
				PRECINCTID = "9-36" OR \
				PRECINCTID = "9-36B" OR \
				PRECINCTID = "9-37" OR \
				PRECINCTID = "9-38" OR \
				PRECINCTID = "9-38A" OR \
				PRECINCTID = "9-39" OR \
				PRECINCTID = "9-39B" OR \
				PRECINCTID = "9-40" OR \
				PRECINCTID = "9-40A" OR \
				PRECINCTID = "9-40C" OR \
				PRECINCTID = "9-41" OR \
				PRECINCTID = "9-41A" OR \
				PRECINCTID = "9-41B" OR \
				PRECINCTID = "9-41C" OR \
				PRECINCTID = "9-41D" OR \
				PRECINCTID = "9-43H" OR \
				PRECINCTID = "9-43M" OR \
				PRECINCTID = "9-43N" OR \
				PRECINCTID = "9-44" OR \
				PRECINCTID = "9-44D" OR \
				PRECINCTID = "9-44E" OR \
				PRECINCTID = "9-44F" OR \
				PRECINCTID = "9-44G" OR \
				PRECINCTID = "9-44I" OR \
				PRECINCTID = "9-44J" OR \
				PRECINCTID = "9-44L" OR \
				PRECINCTID = "9-44M" OR \
				PRECINCTID = "9-44N" OR \
				PRECINCTID = "9-44O" OR \
				PRECINCTID = "9-44P" OR \
				PRECINCTID = "9-44Q" OR \
				PRECINCTID = "9-45" OR \
				PRECINCTID = "9-45A"'
	@ogrinfo $@ -sql "ALTER TABLE opsb-district-1-precincts ADD COLUMN DISTRICT varchar(1)"
	@ogrinfo $@ -dialect sqlite -sql "UPDATE 'opsb-district-1-precincts' SET DISTRICT = '1'"
exports/shp/opsb/opsb-district-1.shp: exports/shp/opsb/opsb-district-1-precincts.shp
	@# Buffer is to remove slivers that were forming inside the district shapes.
	@ogr2ogr $@ $< -dialect sqlite -sql "SELECT st_union(ST_Buffer(GEOMETRY, 0.0000001)) AS geometry, precincts.* FROM 'opsb-district-1-precincts' AS precincts"

exports/shp/opsb/opsb-district-2-precincts.shp: exports/shp/precincts/new-orleans.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-where 'PRECINCTID = "8-4" OR \
				PRECINCTID = "8-6" OR \
				PRECINCTID = "8-7" OR \
				PRECINCTID = "8-8" OR \
				PRECINCTID = "8-9" OR \
				PRECINCTID = "8-12" OR \
				PRECINCTID = "8-13" OR \
				PRECINCTID = "8-14" OR \
				PRECINCTID = "8-15" OR \
				PRECINCTID = "8-19" OR \
				PRECINCTID = "8-20" OR \
				PRECINCTID = "8-21" OR \
				PRECINCTID = "8-22" OR \
				PRECINCTID = "8-23" OR \
				PRECINCTID = "8-24" OR \
				PRECINCTID = "8-30" OR \
				PRECINCTID = "9-10" OR \
				PRECINCTID = "9-17" OR \
				PRECINCTID = "9-19" OR \
				PRECINCTID = "9-21" OR \
				PRECINCTID = "9-23" OR \
				PRECINCTID = "9-25" OR \
				PRECINCTID = "9-26" OR \
				PRECINCTID = "9-28" OR \
				PRECINCTID = "9-28C" OR \
				PRECINCTID = "9-28E" OR \
				PRECINCTID = "9-29" OR \
				PRECINCTID = "9-30" OR \
				PRECINCTID = "9-30A" OR \
				PRECINCTID = "9-31" OR \
				PRECINCTID = "9-31A" OR \
				PRECINCTID = "9-31B" OR \
				PRECINCTID = "9-31D" OR \
				PRECINCTID = "9-33" OR \
				PRECINCTID = "9-34A" OR \
				PRECINCTID = "9-42" OR \
				PRECINCTID = "9-42C" OR \
				PRECINCTID = "9-43A" OR \
				PRECINCTID = "9-43B" OR \
				PRECINCTID = "9-43C" OR \
				PRECINCTID = "9-43E" OR \
				PRECINCTID = "9-43F" OR \
				PRECINCTID = "9-43G" OR \
				PRECINCTID = "9-43I" OR \
				PRECINCTID = "9-43J" OR \
				PRECINCTID = "9-43K" OR \
				PRECINCTID = "9-43L" OR \
				PRECINCTID = "9-44A" OR \
				PRECINCTID = "9-44B"'
	@ogrinfo $@ -sql "ALTER TABLE opsb-district-2-precincts ADD COLUMN DISTRICT varchar(1)"
	@ogrinfo $@ -dialect sqlite -sql "UPDATE 'opsb-district-2-precincts' SET DISTRICT = '2'"
exports/shp/opsb/opsb-district-2.shp: exports/shp/opsb/opsb-district-2-precincts.shp
	@# Buffer is to remove slivers that were forming inside the district shapes.
	@ogr2ogr $@ $< -dialect sqlite -sql "SELECT st_union(ST_Buffer(GEOMETRY, 0.0000001)) AS geometry, precincts.* FROM 'opsb-district-2-precincts' AS precincts"

shp/opsb/opsb-district-3-precincts-untrimmed.shp: exports/shp/precincts/new-orleans.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-where 'PRECINCTID = "3-12" OR \
				PRECINCTID = "3-14" OR \
				PRECINCTID = "3-15" OR \
				PRECINCTID = "3-18" OR \
				PRECINCTID = "3-19" OR \
				PRECINCTID = "3-20" OR \
				PRECINCTID = "4-5" OR \
				PRECINCTID = "4-6" OR \
				PRECINCTID = "4-7" OR \
				PRECINCTID = "4-8" OR \
				PRECINCTID = "4-9" OR \
				PRECINCTID = "4-11" OR \
				PRECINCTID = "4-14" OR \
				PRECINCTID = "4-15" OR \
				PRECINCTID = "4-17" OR \
				PRECINCTID = "4-17A" OR \
				PRECINCTID = "4-18" OR \
				PRECINCTID = "4-20" OR \
				PRECINCTID = "4-21" OR \
				PRECINCTID = "4-22" OR \
				PRECINCTID = "4-23" OR \
				PRECINCTID = "5-8" OR \
				PRECINCTID = "5-9" OR \
				PRECINCTID = "5-10" OR \
				PRECINCTID = "5-11" OR \
				PRECINCTID = "5-12" OR \
				PRECINCTID = "5-13" OR \
				PRECINCTID = "5-15" OR \
				PRECINCTID = "5-16" OR \
				PRECINCTID = "5-17" OR \
				PRECINCTID = "5-18" OR \
				PRECINCTID = "6-9" OR \
				PRECINCTID = "7-12" OR \
				PRECINCTID = "7-17" OR \
				PRECINCTID = "7-18" OR \
				PRECINCTID = "7-19" OR \
				PRECINCTID = "7-30" OR \
				PRECINCTID = "7-32" OR \
				PRECINCTID = "7-33" OR \
				PRECINCTID = "7-34" OR \
				PRECINCTID = "7-35" OR \
				PRECINCTID = "7-37" OR \
				PRECINCTID = "7-37A" OR \
				PRECINCTID = "7-40" OR \
				PRECINCTID = "7-41" OR \
				PRECINCTID = "7-42" OR \
				PRECINCTID = "8-25" OR \
				PRECINCTID = "8-26" OR \
				PRECINCTID = "8-27" OR \
				PRECINCTID = "8-28" OR \
				PRECINCTID = "17-17" OR \
				PRECINCTID = "17-18" OR \
				PRECINCTID = "17-18A" OR \
				PRECINCTID = "17-19" OR \
				PRECINCTID = "17-20"'

exports/shp/opsb/opsb-district-3-precincts.shp: shp/opsb/opsb-district-3-precincts-untrimmed.shp shp/opsb/precinct-5-8-riverside.shp shp/opsb/precinct-7-12-riverside.shp
	@# Remove portion of precincts 5-8 and 7-12. OPSB district doesn't perfectly align with precinct.
	@mkdir -p $(dir $@)
	@mkdir -p tmp
	@echo '<OGRVRTDataSource><OGRVRTLayer name="opsb-district-3-precincts-untrimmed"><SrcDataSource>$<</SrcDataSource></OGRVRTLayer><OGRVRTLayer name="precinct-5-8-riverside"><SrcDataSource>shp/opsb/precinct-5-8-riverside.shp</SrcDataSource></OGRVRTLayer></OGRVRTDataSource>' | \
		ogr2ogr -f 'ESRI Shapefile' \
		tmp/dist-3-minus-5-8.shp /vsistdin/ \
		-dialect sqlite \
		-sql "SELECT ST_Difference(district.GEOMETRY, precinct.GEOMETRY) AS geometry, district.* FROM 'opsb-district-3-precincts-untrimmed' AS district, 'precinct-5-8-riverside' AS precinct"
	@echo '<OGRVRTDataSource><OGRVRTLayer name="dist-3-minus-5-8"><SrcDataSource>tmp/dist-3-minus-5-8.shp</SrcDataSource></OGRVRTLayer><OGRVRTLayer name="precinct-7-12-riverside"><SrcDataSource>shp/opsb/precinct-7-12-riverside.shp</SrcDataSource></OGRVRTLayer></OGRVRTDataSource>' | \
		ogr2ogr -f 'ESRI Shapefile' \
		$@ /vsistdin/ \
		-dialect sqlite \
		-sql "SELECT ST_Difference(district.GEOMETRY, precinct.GEOMETRY) AS geometry, district.* FROM 'dist-3-minus-5-8' AS district, 'precinct-7-12-riverside' AS precinct"
	@rm -rf tmp

	@ogrinfo $@ -sql "ALTER TABLE opsb-district-3-precincts ADD COLUMN DISTRICT varchar(1)"
	@ogrinfo $@ -dialect sqlite -sql "UPDATE 'opsb-district-3-precincts' SET DISTRICT = '3'"
exports/shp/opsb/opsb-district-3.shp: exports/shp/opsb/opsb-district-3-precincts.shp
	@# Buffer is to remove slivers that were forming inside the district shapes.
	@ogr2ogr $@ $< -dialect sqlite -sql "SELECT st_union(ST_Buffer(GEOMETRY, 0.0000001)) AS geometry, precincts.* FROM 'opsb-district-3-precincts' AS precincts"

exports/shp/opsb/opsb-district-4-precincts.shp: exports/shp/precincts/new-orleans.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-where 'PRECINCTID = "5-1" OR \
				PRECINCTID = "6-1" OR \
				PRECINCTID = "8-1" OR \
				PRECINCTID = "8-2" OR \
				PRECINCTID = "9-9" OR \
				PRECINCTID = "9-11" OR \
				PRECINCTID = "9-12" OR \
				PRECINCTID = "9-13" OR \
				PRECINCTID = "9-14" OR \
				PRECINCTID = "9-15" OR \
				PRECINCTID = "9-16" OR \
				PRECINCTID = "15-1" OR \
				PRECINCTID = "15-2" OR \
				PRECINCTID = "15-3" OR \
				PRECINCTID = "15-9" OR \
				PRECINCTID = "15-12" OR \
				PRECINCTID = "15-13" OR \
				PRECINCTID = "15-14" OR \
				PRECINCTID = "15-14A" OR \
				PRECINCTID = "15-14B" OR \
				PRECINCTID = "15-14C" OR \
				PRECINCTID = "15-14D" OR \
				PRECINCTID = "15-14E" OR \
				PRECINCTID = "15-14F" OR \
				PRECINCTID = "15-14G" OR \
				PRECINCTID = "15-15" OR \
				PRECINCTID = "15-15A" OR \
				PRECINCTID = "15-15B" OR \
				PRECINCTID = "15-16" OR \
				PRECINCTID = "15-17" OR \
				PRECINCTID = "15-17A" OR \
				PRECINCTID = "15-17B" OR \
				PRECINCTID = "15-18" OR \
				PRECINCTID = "15-18A" OR \
				PRECINCTID = "15-18B" OR \
				PRECINCTID = "15-18C" OR \
				PRECINCTID = "15-18D" OR \
				PRECINCTID = "15-18E" OR \
				PRECINCTID = "15-18F" OR \
				PRECINCTID = "15-19" OR \
				PRECINCTID = "15-19A" OR \
				PRECINCTID = "15-19B" OR \
				PRECINCTID = "15-19C"'
	@ogrinfo $@ -sql "ALTER TABLE opsb-district-4-precincts ADD COLUMN DISTRICT varchar(1)"
	@ogrinfo $@ -dialect sqlite -sql "UPDATE 'opsb-district-4-precincts' SET DISTRICT = '4'"
exports/shp/opsb/opsb-district-4.shp: exports/shp/opsb/opsb-district-4-precincts.shp
	@# Buffer is to remove slivers that were forming inside the district shapes.
	@ogr2ogr $@ $< -dialect sqlite -sql "SELECT st_union(ST_Buffer(GEOMETRY, 0.0000001)) AS geometry, precincts.* FROM 'opsb-district-4-precincts' AS precincts"

exports/shp/opsb/opsb-district-5-precincts.shp: exports/shp/precincts/new-orleans.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-where 'PRECINCTID = "1-1" OR \
				PRECINCTID = "1-2" OR \
				PRECINCTID = "1-5" OR \
				PRECINCTID = "1-6" OR \
				PRECINCTID = "2-1" OR \
				PRECINCTID = "2-2" OR \
				PRECINCTID = "10-3" OR \
				PRECINCTID = "10-6" OR \
				PRECINCTID = "10-7" OR \
				PRECINCTID = "10-8" OR \
				PRECINCTID = "10-9" OR \
				PRECINCTID = "10-11" OR \
				PRECINCTID = "10-12" OR \
				PRECINCTID = "10-13" OR \
				PRECINCTID = "10-14" OR \
				PRECINCTID = "11-2" OR \
				PRECINCTID = "11-3" OR \
				PRECINCTID = "11-4" OR \
				PRECINCTID = "11-5" OR \
				PRECINCTID = "11-8" OR \
				PRECINCTID = "11-9" OR \
				PRECINCTID = "11-10" OR \
				PRECINCTID = "11-11" OR \
				PRECINCTID = "11-12" OR \
				PRECINCTID = "11-13" OR \
				PRECINCTID = "11-14" OR \
				PRECINCTID = "12-1" OR \
				PRECINCTID = "12-2" OR \
				PRECINCTID = "12-3" OR \
				PRECINCTID = "12-4" OR \
				PRECINCTID = "12-5" OR \
				PRECINCTID = "12-6" OR \
				PRECINCTID = "12-7" OR \
				PRECINCTID = "12-8" OR \
				PRECINCTID = "12-9" OR \
				PRECINCTID = "12-10" OR \
				PRECINCTID = "12-11" OR \
				PRECINCTID = "12-12" OR \
				PRECINCTID = "12-13" OR \
				PRECINCTID = "12-14" OR \
				PRECINCTID = "12-16" OR \
				PRECINCTID = "12-17" OR \
				PRECINCTID = "13-1" OR \
				PRECINCTID = "13-2" OR \
				PRECINCTID = "13-3" OR \
				PRECINCTID = "13-4" OR \
				PRECINCTID = "13-5" OR \
				PRECINCTID = "13-6" OR \
				PRECINCTID = "13-7" OR \
				PRECINCTID = "13-9" OR \
				PRECINCTID = "13-10" OR \
				PRECINCTID = "13-11" OR \
				PRECINCTID = "13-12" OR \
				PRECINCTID = "13-13" OR \
				PRECINCTID = "13-14" OR \
				PRECINCTID = "13-15" OR \
				PRECINCTID = "13-16" OR \
				PRECINCTID = "14-15" OR \
				PRECINCTID = "14-20" OR \
				PRECINCTID = "14-23"'
	@ogrinfo $@ -sql "ALTER TABLE opsb-district-5-precincts ADD COLUMN DISTRICT varchar(1)"
	@ogrinfo $@ -dialect sqlite -sql "UPDATE 'opsb-district-5-precincts' SET DISTRICT = '5'"
exports/shp/opsb/opsb-district-5.shp: exports/shp/opsb/opsb-district-5-precincts.shp
	@# Buffer is to remove slivers that were forming inside the district shapes.
	@ogr2ogr $@ $< -dialect sqlite -sql "SELECT st_union(ST_Buffer(GEOMETRY, 0.0000001)) AS geometry, precincts.* FROM 'opsb-district-5-precincts' AS precincts"

exports/shp/opsb/opsb-district-6-precincts.shp: exports/shp/precincts/new-orleans.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-where 'PRECINCTID = "2-4" OR \
				PRECINCTID = "2-6" OR \
				PRECINCTID = "2-6A" OR \
				PRECINCTID = "2-7" OR \
				PRECINCTID = "11-17" OR \
				PRECINCTID = "12-19" OR \
				PRECINCTID = "13-8" OR \
				PRECINCTID = "14-1" OR \
				PRECINCTID = "14-2" OR \
				PRECINCTID = "14-3" OR \
				PRECINCTID = "14-4" OR \
				PRECINCTID = "14-5" OR \
				PRECINCTID = "14-6" OR \
				PRECINCTID = "14-7" OR \
				PRECINCTID = "14-8" OR \
				PRECINCTID = "14-9" OR \
				PRECINCTID = "14-10" OR \
				PRECINCTID = "14-11" OR \
				PRECINCTID = "14-12" OR \
				PRECINCTID = "14-13A" OR \
				PRECINCTID = "14-14" OR \
				PRECINCTID = "14-16" OR \
				PRECINCTID = "14-17" OR \
				PRECINCTID = "14-18A" OR \
				PRECINCTID = "14-19" OR \
				PRECINCTID = "14-21" OR \
				PRECINCTID = "14-24A" OR \
				PRECINCTID = "14-25" OR \
				PRECINCTID = "14-26" OR \
				PRECINCTID = "16-1" OR \
				PRECINCTID = "16-1A" OR \
				PRECINCTID = "16-2" OR \
				PRECINCTID = "16-3" OR \
				PRECINCTID = "16-4" OR \
				PRECINCTID = "16-5" OR \
				PRECINCTID = "16-6" OR \
				PRECINCTID = "16-7" OR \
				PRECINCTID = "16-8" OR \
				PRECINCTID = "16-9" OR \
				PRECINCTID = "17-1" OR \
				PRECINCTID = "17-2" OR \
				PRECINCTID = "17-3" OR \
				PRECINCTID = "17-4" OR \
				PRECINCTID = "17-5" OR \
				PRECINCTID = "17-6" OR \
				PRECINCTID = "17-7" OR \
				PRECINCTID = "17-8" OR \
				PRECINCTID = "17-9" OR \
				PRECINCTID = "17-10" OR \
				PRECINCTID = "17-11" OR \
				PRECINCTID = "17-12" OR \
				PRECINCTID = "17-13" OR \
				PRECINCTID = "17-13A" OR \
				PRECINCTID = "17-14" OR \
				PRECINCTID = "17-15" OR \
				PRECINCTID = "17-16"'
	@ogrinfo $@ -sql "ALTER TABLE opsb-district-6-precincts ADD COLUMN DISTRICT varchar(1)"
	@ogrinfo $@ -dialect sqlite -sql "UPDATE 'opsb-district-6-precincts' SET DISTRICT = '6'"
exports/shp/opsb/opsb-district-6.shp: exports/shp/opsb/opsb-district-6-precincts.shp
	@# Buffer is to remove slivers that were forming inside the district shapes.
	@ogr2ogr $@ $< -dialect sqlite -sql "SELECT st_union(ST_Buffer(GEOMETRY, 0.0000001)) AS geometry, precincts.* FROM 'opsb-district-6-precincts' AS precincts"

shp/opsb/opsb-district-7-precincts-untrimmed.shp: exports/shp/precincts/new-orleans.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-where 'PRECINCTID = "3-1" OR \
				PRECINCTID = "3-3" OR \
				PRECINCTID = "3-5" OR \
				PRECINCTID = "3-8" OR \
				PRECINCTID = "3-9" OR \
				PRECINCTID = "4-2" OR \
				PRECINCTID = "4-3" OR \
				PRECINCTID = "4-4" OR \
				PRECINCTID = "5-2" OR \
				PRECINCTID = "5-3" OR \
				PRECINCTID = "5-4" OR \
				PRECINCTID = "5-5" OR \
				PRECINCTID = "5-7" OR \
				PRECINCTID = "5-8" OR \
				PRECINCTID = "6-2" OR \
				PRECINCTID = "6-4" OR \
				PRECINCTID = "6-6" OR \
				PRECINCTID = "6-7" OR \
				PRECINCTID = "6-8" OR \
				PRECINCTID = "7-1" OR \
				PRECINCTID = "7-2" OR \
				PRECINCTID = "7-4" OR \
				PRECINCTID = "7-5" OR \
				PRECINCTID = "7-6" OR \
				PRECINCTID = "7-7" OR \
				PRECINCTID = "7-8" OR \
				PRECINCTID = "7-9A" OR \
				PRECINCTID = "7-10" OR \
				PRECINCTID = "7-11" OR \
				PRECINCTID = "7-12" OR \
				PRECINCTID = "7-13" OR \
				PRECINCTID = "7-14" OR \
				PRECINCTID = "7-15" OR \
				PRECINCTID = "7-16" OR \
				PRECINCTID = "7-20" OR \
				PRECINCTID = "7-21" OR \
				PRECINCTID = "7-23" OR \
				PRECINCTID = "7-24" OR \
				PRECINCTID = "7-25" OR \
				PRECINCTID = "7-25A" OR \
				PRECINCTID = "7-26" OR \
				PRECINCTID = "7-27" OR \
				PRECINCTID = "7-27B" OR \
				PRECINCTID = "7-28" OR \
				PRECINCTID = "7-28A" OR \
				PRECINCTID = "7-29" OR \
				PRECINCTID = "15-5" OR \
				PRECINCTID = "15-6" OR \
				PRECINCTID = "15-8" OR \
				PRECINCTID = "15-10" OR \
				PRECINCTID = "15-11" OR \
				PRECINCTID = "15-12A" OR \
				PRECINCTID = "15-13A" OR \
				PRECINCTID = "15-13B"'
exports/shp/opsb/opsb-district-7-precincts.shp: shp/opsb/opsb-district-7-precincts-untrimmed.shp shp/opsb/precinct-5-8-lakeside.shp shp/opsb/precinct-7-12-lakeside.shp
	@# Remove portion of precincts 5-8 and 7-12. OPSB district doesn't perfectly align with precinct.
	@mkdir -p $(dir $@)
	@mkdir -p tmp
	@echo '<OGRVRTDataSource><OGRVRTLayer name="opsb-district-7-precincts-untrimmed"><SrcDataSource>$<</SrcDataSource></OGRVRTLayer><OGRVRTLayer name="precinct-5-8-lakeside"><SrcDataSource>shp/opsb/precinct-5-8-lakeside.shp</SrcDataSource></OGRVRTLayer></OGRVRTDataSource>' | \
		ogr2ogr tmp/opsb-district-7-precinct-5-8.shp /vsistdin/ \
		-overwrite \
		-dialect sqlite \
		-sql "SELECT ST_Difference(district.GEOMETRY, precinct.GEOMETRY) AS geometry, district.* FROM 'opsb-district-7-precincts-untrimmed' AS district, 'precinct-5-8-lakeside' AS precinct"
	@echo '<OGRVRTDataSource><OGRVRTLayer name="opsb-district-7-precinct-5-8"><SrcDataSource>tmp/opsb-district-7-precinct-5-8.shp</SrcDataSource></OGRVRTLayer><OGRVRTLayer name="precinct-7-12-lakeside"><SrcDataSource>shp/opsb/precinct-7-12-lakeside.shp</SrcDataSource></OGRVRTLayer></OGRVRTDataSource>' | \
		ogr2ogr $@ /vsistdin/ \
		-overwrite \
		-dialect sqlite \
		-sql "SELECT ST_Difference(district.GEOMETRY, precinct.GEOMETRY) AS geometry, district.* FROM 'opsb-district-7-precinct-5-8' AS district, 'precinct-7-12-lakeside' AS precinct"
	@rm -rf tmp

	@ogrinfo $@ -sql "ALTER TABLE opsb-district-7-precincts ADD COLUMN DISTRICT varchar(1)"
	@ogrinfo $@ -dialect sqlite -sql "UPDATE 'opsb-district-7-precincts' SET DISTRICT = '7'"
exports/shp/opsb/opsb-district-7.shp: exports/shp/opsb/opsb-district-7-precincts.shp
	@# Buffer is to remove slivers that were forming inside the district shapes.
	@ogr2ogr $@ $< -dialect sqlite -sql "SELECT st_union(ST_Buffer(GEOMETRY, 0.0000001)) AS geometry, precincts.* FROM 'opsb-district-7-precincts' AS precincts"

exports/shp/opsb/opsb.shp: exports/shp/opsb/opsb-district-1.shp \
	exports/shp/opsb/opsb-district-2.shp \
	exports/shp/opsb/opsb-district-3.shp \
	exports/shp/opsb/opsb-district-4.shp \
	exports/shp/opsb/opsb-district-5.shp \
	exports/shp/opsb/opsb-district-6.shp \
	exports/shp/opsb/opsb-district-7.shp

	@mkdir -p $(dir $@)
	@for file in $^; do ogr2ogr -update -append -nln opsb $@ $$file; done
exports/shp/opsb/opsb-precincts.shp: exports/shp/opsb/opsb-district-1-precincts.shp \
	exports/shp/opsb/opsb-district-2-precincts.shp \
	exports/shp/opsb/opsb-district-3-precincts.shp \
	exports/shp/opsb/opsb-district-4-precincts.shp \
	exports/shp/opsb/opsb-district-5-precincts.shp \
	exports/shp/opsb/opsb-district-6-precincts.shp \
	exports/shp/opsb/opsb-district-7-precincts.shp

	@mkdir -p $(dir $@)
	@for file in $^; do ogr2ogr -update -append -nln 'opsb-precincts' $@ $$file; done

exports/shp/opsb/opsb-simplified.shp: exports/shp/opsb/opsb.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0003 \
		-sql "SELECT PRECINCTID AS precinctid, COUNTY AS parishname, DISTRICT AS district FROM opsb"
exports/shp/opsb/opsb-precincts-simplified.shp: exports/shp/opsb/opsb-precincts.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0003 \
		-dialect sqlite \
		-sql "SELECT Geometry, PRECINCTID AS precinctid, DISTRICT AS district, COUNTY AS parishname FROM 'opsb-precincts'"

exports/shp/opsb/opsb-district-1-simplified.shp: exports/shp/opsb/opsb-district-1.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0003 \
		-dialect sqlite \
		-sql "SELECT Geometry, PRECINCTID AS precinctid, COUNTY AS parishname, DISTRICT AS district FROM 'opsb-district-1'"
exports/shp/opsb/opsb-district-1-precincts-simplified.shp: exports/shp/opsb/opsb-district-1-precincts.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0003 \
		-sql "SELECT PRECINCTID AS precinctid, COUNTY AS parishname, DISTRICT AS district FROM 'opsb-district-1-precincts'"

exports/shp/opsb/opsb-district-2-simplified.shp: exports/shp/opsb/opsb-district-2.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0003 \
		-dialect sqlite \
		-sql "SELECT Geometry, PRECINCTID AS precinctid, COUNTY AS parishname, DISTRICT AS district FROM 'opsb-district-2'"
exports/shp/opsb/opsb-district-2-precincts-simplified.shp: exports/shp/opsb/opsb-district-2-precincts.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0003 \
		-sql "SELECT PRECINCTID AS precinctid, COUNTY AS parishname, DISTRICT AS district FROM 'opsb-district-2-precincts'"

exports/shp/opsb/opsb-district-3-simplified.shp: exports/shp/opsb/opsb-district-3.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0003 \
		-dialect sqlite \
		-sql "SELECT Geometry, PRECINCTID AS precinctid, COUNTY AS parishname, DISTRICT AS district FROM 'opsb-district-3'"
exports/shp/opsb/opsb-district-3-precincts-simplified.shp: exports/shp/opsb/opsb-district-3-precincts.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0003 \
		-sql "SELECT PRECINCTID AS precinctid, COUNTY AS parishname, DISTRICT AS district FROM 'opsb-district-3-precincts'"

exports/shp/opsb/opsb-district-4-simplified.shp: exports/shp/opsb/opsb-district-4.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0003 \
		-dialect sqlite \
		-sql "SELECT Geometry, PRECINCTID AS precinctid, COUNTY AS parishname, DISTRICT AS district FROM 'opsb-district-4'"
exports/shp/opsb/opsb-district-4-precincts-simplified.shp: exports/shp/opsb/opsb-district-4-precincts.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0003 \
		-sql "SELECT PRECINCTID AS precinctid, COUNTY AS parishname, DISTRICT AS district FROM 'opsb-district-4-precincts'"

exports/shp/opsb/opsb-district-5-simplified.shp: exports/shp/opsb/opsb-district-5.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0003 \
		-dialect sqlite \
		-sql "SELECT Geometry, PRECINCTID AS precinctid, COUNTY AS parishname, DISTRICT AS district FROM 'opsb-district-5'"
exports/shp/opsb/opsb-district-5-precincts-simplified.shp: exports/shp/opsb/opsb-district-5-precincts.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0003 \
		-sql "SELECT PRECINCTID AS precinctid, COUNTY AS parishname, DISTRICT AS district FROM 'opsb-district-5-precincts'"

exports/shp/opsb/opsb-district-6-simplified.shp: exports/shp/opsb/opsb-district-6.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0003 \
		-dialect sqlite \
		-sql "SELECT Geometry, PRECINCTID AS precinctid, COUNTY AS parishname, DISTRICT AS district FROM 'opsb-district-6'"
exports/shp/opsb/opsb-district-6-precincts-simplified.shp: exports/shp/opsb/opsb-district-6-precincts.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0003 \
		-sql "SELECT PRECINCTID AS precinctid, COUNTY AS parishname, DISTRICT AS district FROM 'opsb-district-6-precincts'"

exports/shp/opsb/opsb-district-7-simplified.shp: exports/shp/opsb/opsb-district-7.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0003 \
		-dialect sqlite \
		-sql "SELECT Geometry, PRECINCTID AS precinctid, COUNTY AS parishname, DISTRICT AS district FROM 'opsb-district-7'"
exports/shp/opsb/opsb-district-7-precincts-simplified.shp: exports/shp/opsb/opsb-district-7-precincts.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0003 \
		-sql "SELECT PRECINCTID AS precinctid, COUNTY AS parishname, DISTRICT AS district FROM 'opsb-district-7-precincts'"

# Export to other file formats
exports/geojson/opsb/%.json: exports/shp/opsb/%.shp
	@mkdir -p $(dir $@)
	@rm -f $@
	@ogr2ogr -f 'GeoJSON' $@ $<
exports/topojson/opsb/%.json: exports/shp/opsb/%.shp
	@mkdir -p $(dir $@)
	@topojson -o $@ $< -p

opsb: exports/shp/opsb/opsb.shp \
	exports/shp/opsb/opsb-district-1.shp \
	exports/shp/opsb/opsb-district-2.shp \
	exports/shp/opsb/opsb-district-3.shp \
	exports/shp/opsb/opsb-district-4.shp \
	exports/shp/opsb/opsb-district-5.shp \
	exports/shp/opsb/opsb-district-6.shp \
	exports/shp/opsb/opsb-district-7.shp \
	exports/shp/opsb/opsb-precincts.shp \
	exports/shp/opsb/opsb-district-1-precincts.shp \
	exports/shp/opsb/opsb-district-2-precincts.shp \
	exports/shp/opsb/opsb-district-3-precincts.shp \
	exports/shp/opsb/opsb-district-4-precincts.shp \
	exports/shp/opsb/opsb-district-5-precincts.shp \
	exports/shp/opsb/opsb-district-6-precincts.shp \
	exports/shp/opsb/opsb-district-7-precincts.shp \
	exports/shp/opsb/opsb-simplified.shp \
	exports/shp/opsb/opsb-district-1-simplified.shp \
	exports/shp/opsb/opsb-district-2-simplified.shp \
	exports/shp/opsb/opsb-district-3-simplified.shp \
	exports/shp/opsb/opsb-district-4-simplified.shp \
	exports/shp/opsb/opsb-district-5-simplified.shp \
	exports/shp/opsb/opsb-district-6-simplified.shp \
	exports/shp/opsb/opsb-district-7-simplified.shp \
	exports/shp/opsb/opsb-precincts-simplified.shp \
	exports/shp/opsb/opsb-district-1-precincts-simplified.shp \
	exports/shp/opsb/opsb-district-2-precincts-simplified.shp \
	exports/shp/opsb/opsb-district-3-precincts-simplified.shp \
	exports/shp/opsb/opsb-district-4-precincts-simplified.shp \
	exports/shp/opsb/opsb-district-5-precincts-simplified.shp \
	exports/shp/opsb/opsb-district-6-precincts-simplified.shp \
	exports/shp/opsb/opsb-district-7-precincts-simplified.shp \
	exports/geojson/opsb/opsb.json \
	exports/geojson/opsb/opsb-district-1.json \
	exports/geojson/opsb/opsb-district-2.json \
	exports/geojson/opsb/opsb-district-3.json \
	exports/geojson/opsb/opsb-district-4.json \
	exports/geojson/opsb/opsb-district-5.json \
	exports/geojson/opsb/opsb-district-6.json \
	exports/geojson/opsb/opsb-district-7.json \
	exports/geojson/opsb/opsb-precincts.json \
	exports/geojson/opsb/opsb-district-1-precincts.json \
	exports/geojson/opsb/opsb-district-2-precincts.json \
	exports/geojson/opsb/opsb-district-3-precincts.json \
	exports/geojson/opsb/opsb-district-4-precincts.json \
	exports/geojson/opsb/opsb-district-5-precincts.json \
	exports/geojson/opsb/opsb-district-6-precincts.json \
	exports/geojson/opsb/opsb-district-7-precincts.json \
	exports/geojson/opsb/opsb-simplified.json \
	exports/geojson/opsb/opsb-district-1-simplified.json \
	exports/geojson/opsb/opsb-district-2-simplified.json \
	exports/geojson/opsb/opsb-district-3-simplified.json \
	exports/geojson/opsb/opsb-district-4-simplified.json \
	exports/geojson/opsb/opsb-district-5-simplified.json \
	exports/geojson/opsb/opsb-district-6-simplified.json \
	exports/geojson/opsb/opsb-district-7-simplified.json \
	exports/geojson/opsb/opsb-precincts-simplified.json \
	exports/geojson/opsb/opsb-district-1-precincts-simplified.json \
	exports/geojson/opsb/opsb-district-2-precincts-simplified.json \
	exports/geojson/opsb/opsb-district-3-precincts-simplified.json \
	exports/geojson/opsb/opsb-district-4-precincts-simplified.json \
	exports/geojson/opsb/opsb-district-5-precincts-simplified.json \
	exports/geojson/opsb/opsb-district-6-precincts-simplified.json \
	exports/geojson/opsb/opsb-district-7-precincts-simplified.json \
	exports/topojson/opsb/opsb.json \
	exports/topojson/opsb/opsb-district-1.json \
	exports/topojson/opsb/opsb-district-2.json \
	exports/topojson/opsb/opsb-district-3.json \
	exports/topojson/opsb/opsb-district-4.json \
	exports/topojson/opsb/opsb-district-5.json \
	exports/topojson/opsb/opsb-district-6.json \
	exports/topojson/opsb/opsb-district-7.json \
	exports/topojson/opsb/opsb-precincts.json \
	exports/topojson/opsb/opsb-district-1-precincts.json \
	exports/topojson/opsb/opsb-district-2-precincts.json \
	exports/topojson/opsb/opsb-district-3-precincts.json \
	exports/topojson/opsb/opsb-district-4-precincts.json \
	exports/topojson/opsb/opsb-district-5-precincts.json \
	exports/topojson/opsb/opsb-district-6-precincts.json \
	exports/topojson/opsb/opsb-district-7-precincts.json \
	exports/topojson/opsb/opsb-simplified.json \
	exports/topojson/opsb/opsb-district-1-simplified.json \
	exports/topojson/opsb/opsb-district-2-simplified.json \
	exports/topojson/opsb/opsb-district-3-simplified.json \
	exports/topojson/opsb/opsb-district-4-simplified.json \
	exports/topojson/opsb/opsb-district-5-simplified.json \
	exports/topojson/opsb/opsb-district-6-simplified.json \
	exports/topojson/opsb/opsb-district-7-simplified.json \
	exports/topojson/opsb/opsb-precincts-simplified.json \
	exports/topojson/opsb/opsb-district-1-precincts-simplified.json \
	exports/topojson/opsb/opsb-district-2-precincts-simplified.json \
	exports/topojson/opsb/opsb-district-3-precincts-simplified.json \
	exports/topojson/opsb/opsb-district-4-precincts-simplified.json \
	exports/topojson/opsb/opsb-district-5-precincts-simplified.json \
	exports/topojson/opsb/opsb-district-6-precincts-simplified.json \
	exports/topojson/opsb/opsb-district-7-precincts-simplified.json

##################################################
#                                                #
#  French Quarter Economic Development District  #
#                                                #
##################################################

# Learn more: http://nola.gov/fqedd/
# Boundaries are center line of Canal Street, Mississippi River, back property line
# of properties along Rampart Street facing river, and back property line of
# properties along Esplanade Avenue facing Uptown.

# Download New Orleans neighborhoods .zip file
zip/misc-new-orleans/fq-econ-dev-dist.zip:
	@mkdir -p $(dir $@)
	@# Hand-made file
	@curl -sS -o $@.download 'https://s3-us-west-2.amazonaws.com/projects.thelensnola.org/geographic-data/hand-made/french-quarter-economic-development-district/fq-econ-dev-dist.zip'
	@mv $@.download $@

# Unzip
exports/shp/misc-new-orleans/%.shp: zip/misc-new-orleans/%.zip
	@mkdir -p $(dir $@)

	@# Extract .zip contents to temporary folder
	@mkdir -p tmp
	@unzip -q -o -d tmp $<

	@# Renaming .zip contents in case they have a space in their names.
	@# Note that this is problematic if there are multiple files with the same file extension.
	@for file in tmp/*.*; do \
		fullfile=$$(basename "$$file") && \
		filename=$${fullfile%.*} && \
		fileextension="$${file##*.}" && \
		cp "$$file" "$(dir $@)$*.$$fileextension" ; \
	done

	@rm -rf tmp

# Simplify geometries
exports/shp/misc-new-orleans/fq-econ-dev-dist-simplified.shp: exports/shp/misc-new-orleans/fq-econ-dev-dist.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0001 \
		-dialect sqlite \
		-sql "SELECT district.GEOMETRY AS geometry, district.* FROM 'fq-econ-dev-dist' AS district"

# Export to other file formats
exports/geojson/misc-new-orleans/%.json: exports/shp/misc-new-orleans/%.shp
	@mkdir -p $(dir $@)
	@rm -f $@
	@ogr2ogr -f 'GeoJSON' $@ $<
exports/topojson/misc-new-orleans/%.json: exports/shp/misc-new-orleans/%.shp
	@mkdir -p $(dir $@)
	@topojson -o $@ $< -p

fq_economic_development_district: exports/shp/misc-new-orleans/fq-econ-dev-dist.shp \
	exports/shp/misc-new-orleans/fq-econ-dev-dist-simplified.shp \
	exports/geojson/misc-new-orleans/fq-econ-dev-dist.json \
	exports/geojson/misc-new-orleans/fq-econ-dev-dist-simplified.json \
	exports/topojson/misc-new-orleans/fq-econ-dev-dist.json \
	exports/topojson/misc-new-orleans/fq-econ-dev-dist-simplified.json

###################
#                 #
#  Neighborhoods  #
#                 #
###################

# Download New Orleans neighborhoods .zip file
zip/neighborhoods/new-orleans.zip:
	@mkdir -p $(dir $@)
	@curl -sS -o $@.download 'https://data.nola.gov/api/geospatial/ukvx-5dku?method=export&format=Shapefile'
	@mv $@.download $@

# Unzip
shp/neighborhoods/%-extracted.shp: zip/neighborhoods/%.zip
	@mkdir -p $(dir $@)

	@# Extract .zip contents to temporary folder
	@mkdir -p tmp
	@unzip -q -o -d tmp $<

	@# Renaming .zip contents in case they have a space in their names.
	@# Note that this is problematic if there are multiple files with the same file extension.
	@for file in tmp/*.*; do \
		fullfile=$$(basename "$$file") && \
		filename=$${fullfile%.*} && \
		fileextension="$${file##*.}" && \
		cp "$$file" "$(dir $@)$*-extracted.$$fileextension" ; \
	done

	@rm -rf tmp

# Change coordinate system to WGS 84 (EPSG:4326)
shp/neighborhoods/%-crs.shp: shp/neighborhoods/%-extracted.shp
	@ogr2ogr -f 'ESRI Shapefile' -t_srs "EPSG:4326" $@ $<

# Remove Mississippi River. Lake Pontchartrain already absent.
# May want to keep OBJECTID and NEIGH_ID for certain cases.
exports/shp/neighborhoods/new-orleans.shp: shp/neighborhoods/new-orleans-crs.shp \
	exports/shp/water/mississippi-river.shp

	@mkdir -p $(dir $@)
	@echo '<OGRVRTDataSource><OGRVRTLayer name="new-orleans-crs"><SrcDataSource>$<</SrcDataSource></OGRVRTLayer><OGRVRTLayer name="mississippi-river"><SrcDataSource>exports/shp/water/mississippi-river.shp</SrcDataSource></OGRVRTLayer></OGRVRTDataSource>' | \
		ogr2ogr $@ /vsistdin/ \
		-dialect sqlite \
		-sql "SELECT ST_Difference(neighborhoods.GEOMETRY, river.GEOMETRY) AS geometry, neighborhoods.* FROM 'new-orleans-crs' AS neighborhoods, 'mississippi-river' AS river"

# Simplify geometries
exports/shp/neighborhoods/new-orleans-simplified.shp: exports/shp/neighborhoods/new-orleans.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0001 \
		-dialect sqlite \
		-sql "SELECT neighborhoods.GEOMETRY AS geometry, neighborhoods.GNOCDC_LAB AS nbhd_name FROM 'new-orleans' AS neighborhoods"

# Export to other file formats
exports/geojson/neighborhoods/%.json: exports/shp/neighborhoods/%.shp
	@mkdir -p $(dir $@)
	@rm -f $@
	@ogr2ogr -f 'GeoJSON' $@ $<
exports/topojson/neighborhoods/%.json: exports/shp/neighborhoods/%.shp
	@mkdir -p $(dir $@)
	@topojson -o $@ $< -p

neighborhoods: exports/shp/neighborhoods/new-orleans.shp \
	exports/shp/neighborhoods/new-orleans-simplified.shp \
	exports/geojson/neighborhoods/new-orleans.json \
	exports/geojson/neighborhoods/new-orleans-simplified.json \
	exports/topojson/neighborhoods/new-orleans.json \
	exports/topojson/neighborhoods/new-orleans-simplified.json

##############
#            #
#  Parishes  #
#            #
##############

# Download parishes .zip file
zip/parishes/tl_2010_22_county10.zip:
	@mkdir -p $(dir $@)
	@curl -sS -o $@.download 'ftp://ftp2.census.gov/geo/pvs/tiger2010st/22_Louisiana/22/$(notdir $@)'
	@mv $@.download $@

# Unzip
shp/parishes/tl_2010_22_county10.shp: zip/parishes/tl_2010_22_county10.zip
	@mkdir -p $(dir $@)
	@unzip -q -o -d $(dir $@) $<

# Fix CRS
shp/parishes/louisiana-crs.shp: shp/parishes/tl_2010_22_county10.shp
	@ogr2ogr -f 'ESRI Shapefile' -t_srs "EPSG:4326" $@ $<

# Create Orleans-only file
exports/shp/parishes/orleans.shp: shp/parishes/louisiana-crs.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'COUNTYFP10 = "071"' \
		$@ $<

# Remove water features
# Louisiana: Remove Gulf of Mexico coastline
exports/shp/parishes/louisiana.shp: shp/parishes/louisiana-crs.shp \
	exports/shp/water/gulf-of-mexico.shp

	@mkdir -p $(dir $@)
	@echo '<OGRVRTDataSource><OGRVRTLayer name="louisiana-crs"><SrcDataSource>$<</SrcDataSource></OGRVRTLayer><OGRVRTLayer name="gulf-of-mexico"><SrcDataSource>exports/shp/water/gulf-of-mexico.shp</SrcDataSource></OGRVRTLayer></OGRVRTDataSource>' | \
		ogr2ogr $@ /vsistdin/ \
		-dialect sqlite \
		-sql "SELECT ST_Difference(parishes.GEOMETRY, gulf.GEOMETRY) AS geometry, \
				parishes.* \
			FROM 'louisiana-crs' AS parishes, 'gulf-of-mexico' AS gulf"
# Orleans: remove lake, keep river
exports/shp/parishes/orleans-no-lake.shp: exports/shp/parishes/orleans.shp \
	exports/shp/water/lake-pontchartrain.shp

	@mkdir -p $(dir $@)
	@echo '<OGRVRTDataSource><OGRVRTLayer name="orleans"><SrcDataSource>$<</SrcDataSource></OGRVRTLayer><OGRVRTLayer name="lake-pontchartrain"><SrcDataSource>exports/shp/water/lake-pontchartrain.shp</SrcDataSource></OGRVRTLayer></OGRVRTDataSource>' | \
		ogr2ogr $@ /vsistdin/ \
		-dialect sqlite \
		-sql "SELECT ST_Difference(orleans.GEOMETRY, lake.GEOMETRY) AS geometry, \
				orleans.COUNTYFP10 AS parishcode, \
				orleans.NAME10 AS parishname \
			FROM orleans, 'lake-pontchartrain' AS lake"
# Orleans: remove lake and river
exports/shp/parishes/orleans-no-lake-no-river.shp: exports/shp/parishes/orleans-no-lake.shp \
	exports/shp/water/mississippi-river.shp

	@mkdir -p $(dir $@)
	@echo '<OGRVRTDataSource><OGRVRTLayer name="orleans-no-lake"><SrcDataSource>$<</SrcDataSource></OGRVRTLayer><OGRVRTLayer name="mississippi-river"><SrcDataSource>exports/shp/water/mississippi-river.shp</SrcDataSource></OGRVRTLayer></OGRVRTDataSource>' | \
		ogr2ogr $@ /vsistdin/ \
		-dialect sqlite \
		-sql "SELECT ST_Difference(orleans.GEOMETRY, river.GEOMETRY) AS geometry, \
				orleans.parishcode, \
				orleans.parishname \
			FROM 'orleans-no-lake' AS orleans, 'mississippi-river' AS river"

# Simplify geometries
exports/shp/parishes/orleans-simplified.shp: exports/shp/parishes/orleans.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
	$@ $< \
	-simplify 0.0003 \
	-dialect sqlite \
	-sql "SELECT orleans.GEOMETRY AS geometry, \
			orleans.COUNTYFP10 AS parishcode, \
			orleans.NAME10 AS parishname \
		FROM orleans"
exports/shp/parishes/orleans-no-lake-simplified.shp: exports/shp/parishes/orleans-no-lake.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' $@ $< -simplify 0.0003
exports/shp/parishes/orleans-no-lake-no-river-simplified.shp: exports/shp/parishes/orleans-no-lake-no-river.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' $@ $< -simplify 0.0003
exports/shp/parishes/louisiana-simplified.shp: exports/shp/parishes/louisiana.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0010 \
		-dialect sqlite \
		-sql "SELECT louisiana.GEOMETRY AS geometry, \
				louisiana.COUNTYFP10 AS parishcode, \
				louisiana.NAME10 AS parishname \
			FROM louisiana"

exports/shp/parishes/parishes.shp: exports/shp/parishes/louisiana.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0020 \
		-dialect sqlite \
		-sql "SELECT louisiana.GEOMETRY AS geometry, \
				louisiana.COUNTYFP10 AS parishcode, \
				louisiana.NAME10 AS parishname \
			FROM louisiana"

# Export to other file formats
exports/geojson/parishes/%.json: exports/shp/parishes/%.shp
	@mkdir -p $(dir $@)
	@rm -f $@
	@ogr2ogr -f 'GeoJSON' $@ $<
exports/topojson/parishes/%.json: exports/shp/parishes/%.shp
	@mkdir -p $(dir $@)
	@topojson -o $@ $< -p

parishes: exports/shp/parishes/louisiana.shp \
	exports/shp/parishes/louisiana-simplified.shp \
	exports/shp/parishes/parishes.shp \
	exports/shp/parishes/orleans.shp \
	exports/shp/parishes/orleans-simplified.shp \
	exports/shp/parishes/orleans-no-lake.shp \
	exports/shp/parishes/orleans-no-lake-simplified.shp \
	exports/shp/parishes/orleans-no-lake-no-river.shp \
	exports/shp/parishes/orleans-no-lake-no-river-simplified.shp \
	exports/geojson/parishes/louisiana.json \
	exports/geojson/parishes/parishes.json \
	exports/geojson/parishes/louisiana-simplified.json \
	exports/geojson/parishes/orleans.json \
	exports/geojson/parishes/orleans-simplified.json \
	exports/geojson/parishes/orleans-no-lake.json \
	exports/geojson/parishes/orleans-no-lake-simplified.json \
	exports/geojson/parishes/orleans-no-lake-no-river.json \
	exports/geojson/parishes/orleans-no-lake-no-river-simplified.json \
	exports/topojson/parishes/louisiana.json \
	exports/topojson/parishes/parishes.json \
	exports/topojson/parishes/louisiana-simplified.json \
	exports/topojson/parishes/orleans.json \
	exports/topojson/parishes/orleans-simplified.json \
	exports/topojson/parishes/orleans-no-lake.json \
	exports/topojson/parishes/orleans-no-lake-simplified.json \
	exports/topojson/parishes/orleans-no-lake-no-river.json \
	exports/topojson/parishes/orleans-no-lake-no-river-simplified.json

########################################################
#                                                      #
#  BESE (Board of Elementary and Secondary Education)  #
#                                                      #
########################################################

zip/bese/%.zip:
	@mkdir -p $(dir $@)
	@curl -sS -o $@.download 'http://house.legis.state.la.us/H_Redistricting2011/ShapfilesAnd2010CensusBlockEquivFiles/Shapefile%20-%20BESE%20-%20Act%202%20(HB519)%20of%20the%202011%20RS.zip'
	@mv $@.download $@

shp/bese/%-extracted.shp: zip/bese/%.zip
	@mkdir -p $(dir $@)

	@# Extract .zip contents to temporary folder
	@mkdir -p tmp
	@unzip -q -o -d tmp $<

	@for file in tmp/*.*; do \
		fullfile=$$(basename "$$file") && \
		filename=$${fullfile%.*} && \
		fileextension="$${file##*.}" && \
		cp "$$file" "$(dir $@)$*-extracted.$$fileextension" ; \
	done

	@rm -rf tmp

# Convert CRS to WGS 84 (EPSG:4326)
shp/bese/%-crs.shp: shp/bese/%-extracted.shp
	@ogr2ogr -f 'ESRI Shapefile' -t_srs "EPSG:4326" $@ $<

# Remove water geometry
exports/shp/bese/bese.shp: shp/bese/bese-crs.shp \
	exports/shp/water/gulf-of-mexico.shp

	@mkdir -p $(dir $@)
	@echo '<OGRVRTDataSource><OGRVRTLayer name="bese-crs"><SrcDataSource>$<</SrcDataSource></OGRVRTLayer><OGRVRTLayer name="gulf-of-mexico"><SrcDataSource>exports/shp/water/gulf-of-mexico.shp</SrcDataSource></OGRVRTLayer></OGRVRTDataSource>' | \
		ogr2ogr $@ /vsistdin/ \
		-dialect sqlite \
		-sql "SELECT ST_Difference(bese.GEOMETRY, ST_Buffer(gulf.GEOMETRY, 0.0075)) AS geometry, bese.* FROM 'bese-crs' AS bese, 'gulf-of-mexico' AS gulf"

# Overall simplified file
exports/shp/bese/bese-simplified.shp: exports/shp/bese/bese.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0003 \
		-dialect sqlite \
		-sql "SELECT bese.GEOMETRY AS geometry, bese.DISTRICT_I AS district FROM bese"

# Split each district into its own file
exports/shp/bese/bese-district-1.shp: exports/shp/bese/bese.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-dialect sqlite \
		-sql "SELECT bese.* FROM bese WHERE DISTRICT_I = '1'"
exports/shp/bese/bese-district-2.shp: exports/shp/bese/bese.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-dialect sqlite \
		-sql "SELECT bese.* FROM bese WHERE DISTRICT_I = '2'"
exports/shp/bese/bese-district-3.shp: exports/shp/bese/bese.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-dialect sqlite \
		-sql "SELECT bese.* FROM bese WHERE DISTRICT_I = '3'"
exports/shp/bese/bese-district-4.shp: exports/shp/bese/bese.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-dialect sqlite \
		-sql "SELECT bese.* FROM bese WHERE DISTRICT_I = '4'"
exports/shp/bese/bese-district-5.shp: exports/shp/bese/bese.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-dialect sqlite \
		-sql "SELECT bese.* FROM bese WHERE DISTRICT_I = '5'"
exports/shp/bese/bese-district-6.shp: exports/shp/bese/bese.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-dialect sqlite \
		-sql "SELECT bese.* FROM bese WHERE DISTRICT_I = '6'"
exports/shp/bese/bese-district-7.shp: exports/shp/bese/bese.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-dialect sqlite \
		-sql "SELECT bese.* FROM bese WHERE DISTRICT_I = '7'"
exports/shp/bese/bese-district-8.shp: exports/shp/bese/bese.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-dialect sqlite \
		-sql "SELECT bese.* FROM bese WHERE DISTRICT_I = '8'"

# Simplify geometry
exports/shp/bese/bese-district-1-simplified.shp: exports/shp/bese/bese-district-1.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0003 \
		-dialect sqlite \
		-sql "SELECT bese.GEOMETRY AS geometry, bese.DISTRICT_I AS district FROM 'bese-district-1' AS bese"
exports/shp/bese/bese-district-2-simplified.shp: exports/shp/bese/bese-district-2.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0003 \
		-dialect sqlite \
		-sql "SELECT bese.GEOMETRY AS geometry, bese.DISTRICT_I AS district FROM 'bese-district-2' AS bese"
exports/shp/bese/bese-district-3-simplified.shp: exports/shp/bese/bese-district-3.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0003 \
		-dialect sqlite \
		-sql "SELECT bese.GEOMETRY AS geometry, bese.DISTRICT_I AS district FROM 'bese-district-3' AS bese"
exports/shp/bese/bese-district-4-simplified.shp: exports/shp/bese/bese-district-4.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0003 \
		-dialect sqlite \
		-sql "SELECT bese.GEOMETRY AS geometry, bese.DISTRICT_I AS district FROM 'bese-district-4' AS bese"
exports/shp/bese/bese-district-5-simplified.shp: exports/shp/bese/bese-district-5.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0003 \
		-dialect sqlite \
		-sql "SELECT bese.GEOMETRY AS geometry, bese.DISTRICT_I AS district FROM 'bese-district-5' AS bese"
exports/shp/bese/bese-district-6-simplified.shp: exports/shp/bese/bese-district-6.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0003 \
		-dialect sqlite \
		-sql "SELECT bese.GEOMETRY AS geometry, bese.DISTRICT_I AS district FROM 'bese-district-6' AS bese"
exports/shp/bese/bese-district-7-simplified.shp: exports/shp/bese/bese-district-7.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0003 \
		-dialect sqlite \
		-sql "SELECT bese.GEOMETRY AS geometry, bese.DISTRICT_I AS district FROM 'bese-district-7' AS bese"
exports/shp/bese/bese-district-8-simplified.shp: exports/shp/bese/bese-district-8.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0003 \
		-dialect sqlite \
		-sql "SELECT bese.GEOMETRY AS geometry, bese.DISTRICT_I AS district FROM 'bese-district-8' AS bese"

# Export to other file formats
exports/geojson/bese/%.json: exports/shp/bese/%.shp
	@mkdir -p $(dir $@)
	@rm -f $@
	@ogr2ogr -f 'GeoJSON' $@ $<
exports/topojson/bese/%.json: exports/shp/bese/%.shp
	@mkdir -p $(dir $@)
	@topojson -o $@ $< -p

bese: exports/shp/bese/bese.shp \
	exports/shp/bese/bese-district-1.shp \
	exports/shp/bese/bese-district-2.shp \
	exports/shp/bese/bese-district-3.shp \
	exports/shp/bese/bese-district-4.shp \
	exports/shp/bese/bese-district-5.shp \
	exports/shp/bese/bese-district-6.shp \
	exports/shp/bese/bese-district-7.shp \
	exports/shp/bese/bese-district-8.shp \
	exports/shp/bese/bese-simplified.shp \
	exports/shp/bese/bese-district-1-simplified.shp \
	exports/shp/bese/bese-district-2-simplified.shp \
	exports/shp/bese/bese-district-3-simplified.shp \
	exports/shp/bese/bese-district-4-simplified.shp \
	exports/shp/bese/bese-district-5-simplified.shp \
	exports/shp/bese/bese-district-6-simplified.shp \
	exports/shp/bese/bese-district-7-simplified.shp \
	exports/shp/bese/bese-district-8-simplified.shp \
	exports/geojson/bese/bese.json \
	exports/geojson/bese/bese-district-1.json \
	exports/geojson/bese/bese-district-2.json \
	exports/geojson/bese/bese-district-3.json \
	exports/geojson/bese/bese-district-4.json \
	exports/geojson/bese/bese-district-5.json \
	exports/geojson/bese/bese-district-6.json \
	exports/geojson/bese/bese-district-7.json \
	exports/geojson/bese/bese-district-8.json \
	exports/geojson/bese/bese-simplified.json \
	exports/geojson/bese/bese-district-1-simplified.json \
	exports/geojson/bese/bese-district-2-simplified.json \
	exports/geojson/bese/bese-district-3-simplified.json \
	exports/geojson/bese/bese-district-4-simplified.json \
	exports/geojson/bese/bese-district-5-simplified.json \
	exports/geojson/bese/bese-district-6-simplified.json \
	exports/geojson/bese/bese-district-7-simplified.json \
	exports/geojson/bese/bese-district-8-simplified.json \
	exports/topojson/bese/bese.json \
	exports/topojson/bese/bese-district-1.json \
	exports/topojson/bese/bese-district-2.json \
	exports/topojson/bese/bese-district-3.json \
	exports/topojson/bese/bese-district-4.json \
	exports/topojson/bese/bese-district-5.json \
	exports/topojson/bese/bese-district-6.json \
	exports/topojson/bese/bese-district-7.json \
	exports/topojson/bese/bese-district-8.json \
	exports/topojson/bese/bese-simplified.json \
	exports/topojson/bese/bese-district-1-simplified.json \
	exports/topojson/bese/bese-district-2-simplified.json \
	exports/topojson/bese/bese-district-3-simplified.json \
	exports/topojson/bese/bese-district-4-simplified.json \
	exports/topojson/bese/bese-district-5-simplified.json \
	exports/topojson/bese/bese-district-6-simplified.json \
	exports/topojson/bese/bese-district-7-simplified.json \
	exports/topojson/bese/bese-district-8-simplified.json

###############
#             #
#  Precincts  #
#             #
###############

# Download Louisiana precincts shapefile. NOTE: These are almost always outdated!
zip/precincts/louisiana.zip:
	@mkdir -p $(dir $@)
	@curl -sS -o $@.download 'http://house.louisiana.gov/H_Redistricting2011/Shapefiles/2014_LouisianaPrecinctShapefile.ZIP'
	@mv $@.download $@
# Download precincts shapefile from data.nola.gov
zip/precincts/new-orleans.zip:
	@mkdir -p $(dir $@)
	@curl -sS -o $@.download 'https://data.nola.gov/api/geospatial/vycb-i8x3?method=export&format=Shapefile'
	@mv $@.download $@

# Unzip downloaded .zip files.
shp/precincts/%-extracted.shp: zip/precincts/%.zip
	@mkdir -p $(dir $@)

	@# Extract .zip contents to temporary folder
	@mkdir -p tmp
	@unzip -q -o -d tmp $<

	@for file in tmp/*.*; do \
		fullfile=$$(basename "$$file") && \
		filename=$${fullfile%.*} && \
		fileextension="$${file##*.}" && \
		cp "$$file" "$(dir $@)$*-extracted.$$fileextension" ; \
	done

	@rm -rf tmp

# Converting coordinate reference systems to WGS 84 (EPSG:4326).
# Louisiana comes with CRS of GCS North American Datum 1983 (NAD83).
# New Orleans comes with CRS of NAD_1983_StatePlane_Louisiana_South_FIPS_1702_Feet.
shp/precincts/%-crs.shp: shp/precincts/%-extracted.shp
	@ogr2ogr -f 'ESRI Shapefile' -t_srs "EPSG:4326" $@ $<

# Remove water geometry.
# Louisiana precincts.
shp/precincts/louisianacodeonly.shp: shp/precincts/louisiana-crs.shp \
	exports/shp/water/gulf-of-mexico.shp

	@mkdir -p $(dir $@)

	@# A. This method takes about 20 minutes.
	@# A-1.) Diffing only coastal precincts and Gulf of Mexico
	@echo '<OGRVRTDataSource><OGRVRTLayer name="louisiana-crs"><SrcDataSource>$<</SrcDataSource></OGRVRTLayer><OGRVRTLayer name="gulf-of-mexico"><SrcDataSource>exports/shp/water/gulf-of-mexico.shp</SrcDataSource></OGRVRTLayer></OGRVRTDataSource>' | \
		ogr2ogr shp/precincts/coastal-diff.shp /vsistdin/ \
			-overwrite \
			-dialect sqlite \
			-sql "SELECT ST_Difference(precincts.GEOMETRY, ST_Buffer(gulf.GEOMETRY, 0.00075)) AS geometry, precincts.* FROM 'louisiana-crs' as precincts, 'gulf-of-mexico' AS gulf WHERE OBJECTID = '629' OR OBJECTID = '634' OR OBJECTID = '639' OR OBJECTID = '15226' OR OBJECTID = '3371' OR OBJECTID = '3396' OR OBJECTID = '3399' OR OBJECTID = '1156' OR OBJECTID = '2962' OR OBJECTID = '2990' OR OBJECTID = '8473' OR OBJECTID = '3333' OR OBJECTID = '3316' OR OBJECTID = '13924' OR OBJECTID = '3267' OR OBJECTID = '3322' OR OBJECTID = '1675' OR OBJECTID = '1655' OR OBJECTID = '1359' OR OBJECTID = '1368' OR OBJECTID = '16177' OR OBJECTID = '16179' OR OBJECTID = '16181' OR OBJECTID = '16180' OR OBJECTID = '2447' OR OBJECTID = '2676' OR OBJECTID = '3143'"
	@# A-2.) Removing coastal precincts from Louisiana precincts
	@ogr2ogr -f 'ESRI Shapefile' \
		-overwrite \
		-where "OBJECTID != '629' AND OBJECTID != '634' AND OBJECTID != '639' AND OBJECTID != '15226' AND OBJECTID != '3371' AND OBJECTID != '3396' AND OBJECTID != '1156' AND OBJECTID != '2990' AND OBJECTID != '8473' AND OBJECTID != '3333' AND OBJECTID != '13924' AND OBJECTID != '1655' AND OBJECTID != '1368' AND OBJECTID != '16177' AND OBJECTID != '16179' AND OBJECTID != '16181' AND OBJECTID != '16180' AND OBJECTID != '2447' AND OBJECTID != '2676' AND OBJECTID != '3143'" \
		shp/precincts/non-coastal.shp $<
	@# A-3.) Joining the two files (Louisiana precincts minus coastal precincts
	@# and the land-only portion of coastal precincts).
	@ogr2ogr -update -append -nln louisianacodeonly $@ shp/precincts/coastal-diff.shp
	@ogr2ogr -update -append -nln louisianacodeonly $@ shp/precincts/non-coastal.shp

	@# B.) Full, slow process. Takes about 3.5 hours.
	@# echo '<OGRVRTDataSource><OGRVRTLayer name="louisiana-crs"><SrcDataSource>$<</SrcDataSource></OGRVRTLayer><OGRVRTLayer name="gulf-of-mexico"><SrcDataSource>exports/shp/water/gulf-of-mexico.shp</SrcDataSource></OGRVRTLayer></OGRVRTDataSource>' | ogr2ogr $@ /vsistdin/ -dialect sqlite -sql "SELECT ST_Difference(precincts.GEOMETRY, ST_Buffer(gulf.GEOMETRY, 0.00075)) AS geometry, precincts.* FROM 'louisiana-crs' AS precincts, 'gulf-of-mexico' AS gulf"

exports/shp/precincts/louisiana.shp: shp/precincts/louisianacodeonly.shp
	@# JOIN the FIPS codes and names by using CSV with codes + parish names.
	@createdb tempdb
	@psql tempdb -c "CREATE EXTENSION postgis;"
	@shp2pgsql -s 4326 shp/precincts/louisianacodeonly louisianacodeonly | psql -d tempdb
	@psql tempdb -c "CREATE TABLE fipslink (FIPS varchar(3), name varchar(50));"
	@psql tempdb -c "COPY fipslink (FIPS, name) FROM '$(shell pwd)/data/fips-codes.csv' DELIMITER ',' CSV HEADER;"
	@pgsql2shp -f $@ tempdb "SELECT louisianacodeonly.*, fipslink.name FROM louisianacodeonly JOIN fipslink ON louisianacodeonly.countyfp10 = fipslink.fips;"
	@dropdb tempdb

# New Orleans. Requires exported Mississippi River shapefile. Lake Pontchartrain is already removed in the raw source.
exports/shp/precincts/new-orleans.shp: shp/precincts/new-orleans-crs.shp \
	exports/shp/water/mississippi-river.shp

	@mkdir -p $(dir $@)
	@echo '<OGRVRTDataSource><OGRVRTLayer name="new-orleans-crs"><SrcDataSource>$<</SrcDataSource></OGRVRTLayer><OGRVRTLayer name="mississippi-river"><SrcDataSource>exports/shp/water/mississippi-river.shp</SrcDataSource></OGRVRTLayer></OGRVRTDataSource>' | \
		ogr2ogr $@ /vsistdin/ \
		-dialect sqlite \
		-sql "SELECT ST_Difference(precincts.GEOMETRY, river.GEOMETRY) AS geometry, precincts.* FROM 'new-orleans-crs' AS precincts, 'mississippi-river' AS river"

# Simplify precincts geometry
exports/shp/precincts/louisiana-simplified.shp: exports/shp/precincts/louisiana.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0003 \
		-dialect sqlite \
		-sql "SELECT louisiana.GEOMETRY AS geometry, louisiana.COUNTYFP10 AS parishcode, louisiana.VTDST10 AS precinctid, louisiana.NAME AS parishname FROM louisiana"
exports/shp/precincts/new-orleans-simplified.shp: exports/shp/precincts/new-orleans.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-simplify 0.0003 \
		-dialect sqlite \
		-sql "SELECT precincts.GEOMETRY, \
				precincts.PRECINCTID AS precinctid, \
				precincts.COUNTY AS parishname \
			FROM 'new-orleans' AS precincts"

exports/shp/precincts/precincts.shp: exports/shp/precincts/new-orleans.shp
	@mkdir -p $(dir $@)
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-dialect sqlite \
		-sql "SELECT precincts.GEOMETRY, \
				precincts.PRECINCTID AS precinctid, \
				precincts.COUNTY AS parishname \
			FROM 'new-orleans' AS precincts"

# Export to other file formats
exports/geojson/precincts/%.json: exports/shp/precincts/%.shp
	@mkdir -p $(dir $@)
	@rm -f $@
	@ogr2ogr -f 'GeoJSON' $@ $<
exports/topojson/precincts/%.json: exports/shp/precincts/%.shp
	@mkdir -p $(dir $@)
	@topojson -o $@ $< -p

precincts: exports/shp/precincts/new-orleans.shp \
	exports/shp/precincts/new-orleans-simplified.shp \
	exports/shp/precincts/precincts.shp \
	exports/shp/precincts/louisiana.shp \
	exports/shp/precincts/louisiana-simplified.shp \
	exports/geojson/precincts/new-orleans.json \
	exports/geojson/precincts/precincts.json \
	exports/geojson/precincts/new-orleans-simplified.json \
	exports/geojson/precincts/louisiana.json \
	exports/geojson/precincts/louisiana-simplified.json \
	exports/topojson/precincts/new-orleans.json \
	exports/topojson/precincts/precincts.json \
	exports/topojson/precincts/new-orleans-simplified.json \
	exports/topojson/precincts/louisiana.json \
	exports/topojson/precincts/louisiana-simplified.json

###########
#         #
#  Water  #
#         #
###########

# Download U.S. Census data
zip/water/tl_2015_%_areawater.zip:
	@mkdir -p $(dir $@)
	@curl -sS -o $@.download 'ftp://ftp2.census.gov/geo/tiger/TIGER2015/AREAWATER/$(notdir $@)'
	@mv $@.download $@

# Unzip U.S. Census data
shp/water/tl_2015_%_areawater.shp: zip/water/tl_2015_%_areawater.zip
	@mkdir -p $(dir $@)
	@unzip -q -o -d $(dir $@) $<

# Convert U.S. Census shapefiles to WGS 84.
shp/water/tl_2015_%_areawater-crs.shp: shp/water/tl_2015_%_areawater.shp
	@ogr2ogr -f 'ESRI Shapefile' -t_srs 'EPSG:4326' $@ $<

# Selecting relevant features of counties and parishes along Mississippi River
shp/water/tl_2015_28055_areawater-ms-river-features.shp: shp/water/tl_2015_28055_areawater-crs.shp
	@# Issaquena County (055)
	@ogr2ogr \
		-f 'ESRI Shapefile' \
		-where 'HYDROID = "110340680889" OR HYDROID = "1102213267559" OR HYDROID = "1102213267560"' \
		$@ $<
shp/water/tl_2015_28149_areawater-ms-river-features.shp: shp/water/tl_2015_28149_areawater-crs.shp
	@# Warren County (149)
	@ogr2ogr \
		-f 'ESRI Shapefile' \
		-where 'HYDROID = "110514218126" OR HYDROID = "110514218125" OR HYDROID = "110514218127" OR HYDROID = "110514218342"' \
		$@ $<
shp/water/tl_2015_28021_areawater-ms-river-features.shp: shp/water/tl_2015_28021_areawater-crs.shp
	@# Claiborne County (021)
	@ogr2ogr \
		-f 'ESRI Shapefile' \
		-where 'HYDROID = "1102213069121" OR HYDROID = "110513956926"' \
		$@ $<
shp/water/tl_2015_28063_areawater-ms-river-features.shp: shp/water/tl_2015_28063_areawater-crs.shp
	@# Jefferson County (063)
	@ogr2ogr \
		-f 'ESRI Shapefile' \
		-where 'HYDROID = "110805477038" OR HYDROID = "110805477039"' \
		$@ $<
shp/water/tl_2015_28001_areawater-ms-river-features.shp: shp/water/tl_2015_28001_areawater-crs.shp
	@# Adams County (001)
	@ogr2ogr \
		-f 'ESRI Shapefile' \
		-where 'HYDROID = "110513669976"' \
		$@ $<
shp/water/tl_2015_28157_areawater-ms-river-features.shp: shp/water/tl_2015_28157_areawater-crs.shp
	@# Wilkinson County (157)
	@ogr2ogr \
		-f 'ESRI Shapefile' \
		-where 'HYDROID = "1101193844330" OR HYDROID = "1101193844359"' \
		$@ $<
shp/water/tl_2015_22035_areawater-ms-river-features.shp: shp/water/tl_2015_22035_areawater-crs.shp
	@# East Carroll Parish (035)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "110465450505" OR HYDROID = "110465450506" OR HYDROID = "110465450508" OR HYDROID = "110465450510"' \
		$@ $<
shp/water/tl_2015_22065_areawater-ms-river-features.shp: shp/water/tl_2015_22065_areawater-crs.shp
	@# Madison Parish (065)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "110469092180" OR HYDROID = "110469092179" OR HYDROID = "110469092177"' \
		$@ $<
shp/water/tl_2015_22107_areawater-ms-river-features.shp: shp/water/tl_2015_22107_areawater-crs.shp
	@# Tensas Parish (107)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "110511027323" OR HYDROID = "110511027210" OR HYDROID = "110511027209"' \
		$@ $<
shp/water/tl_2015_22029_areawater-ms-river-features.shp: shp/water/tl_2015_22029_areawater-crs.shp
	@# Concordia Parish (029)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "110465442145" OR HYDROID = "110465442146" OR HYDROID = "110465442143" OR HYDROID = "110465442144" OR HYDROID = "110465442345" OR HYDROID = "110465442147"' \
		$@ $<
shp/water/tl_2015_22125_areawater-ms-river-features.shp: shp/water/tl_2015_22125_areawater-crs.shp
	@# West Feliciana Parish (125)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "1102213069158" OR HYDROID = "1102390448523" OR HYDROID = "110510925155" OR HYDROID = "1102390448515" OR HYDROID = "1102216246222"' \
		$@ $<
shp/water/tl_2015_22121_areawater-ms-river-features.shp: shp/water/tl_2015_22121_areawater-crs.shp
	@# West Baton Rouge Parish (121)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "11080473761" OR HYDROID = "1102214490138"' \
		$@ $<
shp/water/tl_2015_22033_areawater-ms-river-features.shp: shp/water/tl_2015_22033_areawater-crs.shp
	@# East Baton Rouge Parish (033)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "110507790752"' \
		$@ $<
shp/water/tl_2015_22047_areawater-ms-river-features.shp: shp/water/tl_2015_22047_areawater-crs.shp
	@# Iberville Parish (047)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "11081526535"' \
		$@ $<
shp/water/tl_2015_22005_areawater-ms-river-features.shp: shp/water/tl_2015_22005_areawater-crs.shp
	@# Ascension Parish (005)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "1102214490137"' \
		$@ $<
shp/water/tl_2015_22093_areawater-ms-river-features.shp: shp/water/tl_2015_22093_areawater-crs.shp
	@# St. James Parish (093)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "11054202260"' \
		$@ $<
shp/water/tl_2015_22095_areawater-ms-river-features.shp: shp/water/tl_2015_22095_areawater-crs.shp
	@# St. John the Baptist Parish (095)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "1104493000535"' \
		$@ $<
shp/water/tl_2015_22089_areawater-ms-river-features.shp: shp/water/tl_2015_22089_areawater-crs.shp
	@# St. Charles Parish (089)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "1104493000532"' \
		$@ $<
shp/water/tl_2015_22051_areawater-ms-river-features.shp: shp/water/tl_2015_22051_areawater-crs.shp
	@# Jefferson Parish (051)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "110469043508"' \
		$@ $<
shp/water/tl_2015_22071_areawater-ms-river-features.shp: shp/water/tl_2015_22071_areawater-crs.shp
	@# Orleans Parish (071)
	@# There is a sliver-shaped hole that has to be filled in this portion.
	@# See this post for an explanation of the PostGIS function below:
	@# http://geospatial.commons.gc.cuny.edu/2013/11/04/filling-in-holes-with-postgis/
	@mkdir -p tmp
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "1102214490140" OR HYDROID = "1102216207626" OR HYDROID = "110469170820"' \
		tmp/msriverorleans.shp $<
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ tmp/msriverorleans.shp \
		-dialect sqlite \
		-sql 'SELECT ST_Collect(ST_MakePolygon(geom)) AS geom, * \
			FROM ( \
			    SELECT ST_ExteriorRing(msriverorleans.GEOMETRY) AS geom, * \
			    FROM msriverorleans \
			) AS s \
			GROUP BY HYDROID'
	@rm -rf tmp
shp/water/tl_2015_22087_areawater-ms-river-features.shp: shp/water/tl_2015_22087_areawater-crs.shp
	@# St. Bernard Parish (087)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "110507905010" OR HYDROID = "110507911178" OR HYDROID = "110507905009"' \
		$@ $<
shp/water/tl_2015_22075_areawater-ms-river-features.shp: shp/water/tl_2015_22075_areawater-crs.shp
	@# Plaquemines Parish (075)
	@# The feature with HYDROID = '1102295075770' extends up into the Mississippi River.
	@# To avoid this, clip the feature to only include the river portion of the feature.
	@ogr2ogr -f 'ESRI Shapefile' \
		$@ $< \
		-clipsrc -95.0 29.083 -80.0 35.0 \
		-where 'HYDROID = "1102295075770" OR HYDROID = "11081627078"'

# Gulf of Mexico features
shp/water/tl_2015_22023_areawater-gulf-of-mexico-features.shp: shp/water/tl_2015_22023_areawater-crs.shp
	@# Cameron Parish (023)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "110441630367"' \
		$@ $<
shp/water/tl_2015_22113_areawater-gulf-of-mexico-features.shp: shp/water/tl_2015_22113_areawater-crs.shp
	@# Vermilion Parish (113)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "1102214410271" OR HYDROID = "110456807941" OR HYDROID = "1102390119247"' \
		$@ $<
shp/water/tl_2015_22045_areawater-gulf-of-mexico-features.shp: shp/water/tl_2015_22045_areawater-crs.shp
	@# Iberia Parish (045)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "110468930422" OR HYDROID = "110468930924" OR HYDROID = "110468930424" OR HYDROID = "110468930423" OR HYDROID = "110468930925" OR HYDROID = "110468930458" OR HYDROID = "110468930461" OR HYDROID = "110468930425"' \
		$@ $<
shp/water/tl_2015_22101_areawater-gulf-of-mexico-features.shp: shp/water/tl_2015_22101_areawater-crs.shp
	@# St. Mary Parish (101)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "110444747440" OR HYDROID = "1102390119031" OR HYDROID = "1102390118908" OR HYDROID = "110444747441" OR HYDROID = "1102390119074" OR HYDROID = "1102390117358" OR HYDROID = "1102390119563" OR HYDROID = "110444749627"' \
		$@ $<
shp/water/tl_2015_22109_areawater-gulf-of-mexico-features.shp: shp/water/tl_2015_22109_areawater-crs.shp
	@# Terrebonne Parish (109)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "11054216177" OR HYDROID = "11054211544" OR HYDROID = "11054216176" OR HYDROID = "11054223976" OR HYDROID = "11054219767" OR HYDROID = "11054220571" OR HYDROID = "11054209445" OR HYDROID = "11054216518" OR HYDROID = "11054219061" OR HYDROID = "11054227999" OR HYDROID = "11054223075" OR HYDROID = "11054218298" OR HYDROID = "11054219584" OR HYDROID = "11054217722" OR HYDROID = "11054209736" OR HYDROID = "11054208388" OR HYDROID = "11054216196" OR HYDROID = "11054208146" OR HYDROID = "11054228005" OR HYDROID = "11054226740" OR HYDROID = "1103700136408"' \
		$@ $<
shp/water/tl_2015_22057_areawater-gulf-of-mexico-features.shp: shp/water/tl_2015_22057_areawater-crs.shp
	@# Lafourche Parish (057)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "110518572586" OR HYDROID = "110518572274" OR HYDROID = "110518572287" OR HYDROID = "110518572276" OR HYDROID = "110518572275" OR HYDROID = "1102216631301" OR HYDROID = "110518573217" OR HYDROID = "1104493254140" OR HYDROID = "1104493254310" OR HYDROID = "110518573528" OR HYDROID = "110518572283" OR HYDROID = "110518572250" OR HYDROID = "110518572168" OR HYDROID = "110518572218" OR HYDROID = "110518572165" OR HYDROID = "110518572269" OR HYDROID = "110518572217"' \
		$@ $<
shp/water/tl_2015_22051_areawater-gulf-of-mexico-features.shp: shp/water/tl_2015_22051_areawater-crs.shp
	@# Jefferson Parish (051)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "110469043494" OR HYDROID = "1104493254309" OR HYDROID = "1104493254139" OR HYDROID = "110469043467" OR HYDROID = "1102216201441" OR HYDROID = "110469044191" OR HYDROID = "1102390333013" OR HYDROID = "110469044200" OR HYDROID = "110469043745" OR HYDROID = "110469043484" OR HYDROID = "110469044167" OR HYDROID = "110469043524" OR HYDROID = "110469044189" OR HYDROID = "110469043523" OR HYDROID = "110469043442" OR HYDROID = "110469044192" OR HYDROID = "110469044193" OR HYDROID = "110469043489" OR HYDROID = "110469044212" OR HYDROID = "110469044171"' \
		$@ $<
shp/water/tl_2015_22075_areawater-gulf-of-mexico-features.shp: shp/water/tl_2015_22075_areawater-crs.shp
	@# Plaquemines Parish (075)
	@# The feature with HYDROID = '1102295075770' extends up into the Mississippi River.
	@# To avoid this, first clip the feature to only include the Gulf portion of the feature.
	@mkdir -p tmp
	@ogr2ogr -f 'ESRI Shapefile' \
		tmp/plaquemines-single.shp $< \
		-clipsrc -89.51 28.74 -88.89 29.083 \
		-where 'HYDROID = "1102295075770"'
	@# All the other Gulf features of Plaquemines Parish
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "11081624028" OR HYDROID = "11081623715" OR HYDROID = "11081623817" OR HYDROID = "11081633109" OR HYDROID = "11081626769" OR HYDROID = "11081624022" OR HYDROID = "11081633206" OR HYDROID = "11081624030" OR HYDROID = "11081624163" OR HYDROID = "11081623931" OR HYDROID = "11081633178" OR HYDROID = "11081624024" OR HYDROID = "11081624130" OR HYDROID = "11081626588" OR HYDROID = "11081624025" OR HYDROID = "11081624187" OR HYDROID = "1102390333224" OR HYDROID = "11081623786" OR HYDROID = "1102390332906" OR HYDROID = "11081623978" OR HYDROID = "11081623552" OR HYDROID = "11081633115" OR HYDROID = "11081623887" OR HYDROID = "11081633191" OR HYDROID = "11081633190" OR HYDROID = "11081633068" OR HYDROID = "11081633113" OR HYDROID = "11081624035" OR HYDROID = "11081624201" OR HYDROID = "11081623882" OR HYDROID = "11081624159" OR HYDROID = "11081624109" OR HYDROID = "11081623957" OR HYDROID = "11081623941" OR HYDROID = "11081623762" OR HYDROID = "11081623759" OR HYDROID = "11081623714" OR HYDROID = "11081623836" OR HYDROID = "11081623837" OR HYDROID = "11081633210" OR HYDROID = "11081623898" OR HYDROID = "11081633201" OR HYDROID = "11081633209" OR HYDROID = "11081623798" OR HYDROID = "11081624133" OR HYDROID = "11081624180" OR HYDROID = "11081624083" OR HYDROID = "11081623787" OR HYDROID = "11081623833" OR HYDROID = "11081633153" OR HYDROID = "11081623863" OR HYDROID = "11081624016" OR HYDROID = "11081623960" OR HYDROID = "11081623880" OR HYDROID = "11081624062" OR HYDROID = "11081624064" OR HYDROID = "11081624065" OR HYDROID = "11081623646" OR HYDROID = "11081623945" OR HYDROID = "11081623793" OR HYDROID = "11081624083" OR HYDROID = "11081623863" OR HYDROID = "11081623880" OR HYDROID = "11081624065" OR HYDROID = "11081633160" OR HYDROID = "11081623793" OR HYDROID = "11081623945" OR HYDROID = "11081623914" OR HYDROID = "11081624180" OR HYDROID = "11081624133" OR HYDROID = "11081623798" OR HYDROID = "11081623635" OR HYDROID = "11081633201" OR HYDROID = "11081623898" OR HYDROID = "11081624177" OR HYDROID = "11081633210" OR HYDROID = "11081623762" OR HYDROID = "11081624094" OR HYDROID = "11081623613"' \
		tmp/plaquemines-others.shp $<
	@# Merge the two Plaquemines files
	@ogr2ogr -update -append -nln "tl_2015_22075_areawater-gulf-of-mexico-features" $@ tmp/plaquemines-single.shp
	@ogr2ogr -update -append -nln "tl_2015_22075_areawater-gulf-of-mexico-features" $@ tmp/plaquemines-others.shp
	@rm -rf tmp
shp/water/tl_2015_22087_areawater-gulf-of-mexico-features.shp: shp/water/tl_2015_22087_areawater-crs.shp
	@# St. Bernard Parish (087)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "110507910857" OR HYDROID = "110507905016" OR HYDROID = "110507904785" OR HYDROID = "110507905054" OR HYDROID = "110507910867" OR HYDROID = "1104492838904" OR HYDROID = "110507905053" OR HYDROID = "110507904867" OR HYDROID = "110507904989" OR HYDROID = "110507904982" OR HYDROID = "110507905040" OR HYDROID = "110507905037" OR HYDROID = "110507909599" OR HYDROID = "110507905056" OR HYDROID = "110507910850" OR HYDROID = "110507905066" OR HYDROID = "110507909687" OR HYDROID = "110507904840" OR HYDROID = "110507904871" OR HYDROID = "110507909600" OR HYDROID = "110507904783" OR HYDROID = "110507904942" OR HYDROID = "110507904843" OR HYDROID = "110507904839" OR HYDROID = "110507904845" OR HYDROID = "110507904838" OR HYDROID = "110507905025" OR HYDROID = "110507904965" OR HYDROID = "110507905029" OR HYDROID = "110507905011" OR HYDROID = "110507905022" OR HYDROID = "110507905028" OR HYDROID = "110507905005" OR HYDROID = "110507904927" OR HYDROID = "110507904977" OR HYDROID = "110507905006"' \
		$@ $<
shp/water/tl_2015_22103_areawater-gulf-of-mexico-features.shp: shp/water/tl_2015_22103_areawater-crs.shp
	@# St. Tammany (103)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "1102730928027" OR HYDROID = "1104493254387" OR HYDROID = "1104493254345"' \
		$@ $<
# Mississipi's (28) Gulf counties
shp/water/tl_2015_28045_areawater-gulf-of-mexico-features.shp: shp/water/tl_2015_28045_areawater-crs.shp
	@# Harrison County (047)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "1104493254384" OR HYDROID = "1104493254343" OR HYDROID = "11092979163" OR HYDROID = "11092979223" OR HYDROID = "11092979209"' \
		$@ $<
shp/water/tl_2015_28047_areawater-gulf-of-mexico-features.shp: shp/water/tl_2015_28047_areawater-crs.shp
	@# Harrison County (047)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "110169774582" OR HYDROID = "110169774602" OR HYDROID = "110169774603" OR HYDROID = "1104492838905"' \
		$@ $<

# Lake Pontchartrain features
shp/water/tl_2015_22095_areawater-lake-pontchartrain-features.shp: shp/water/tl_2015_22095_areawater-crs.shp
	@# St. John the Baptist Parish (095)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "1104492831900"' \
		$@ $<
shp/water/tl_2015_22089_areawater-lake-pontchartrain-features.shp: shp/water/tl_2015_22089_areawater-crs.shp
	@# St. Charles Parish (089)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "1104492831902"' \
		$@ $<
shp/water/tl_2015_22051_areawater-lake-pontchartrain-features.shp: shp/water/tl_2015_22051_areawater-crs.shp
	@# Jefferson Parish (051)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "1104701918974" OR HYDROID = "110469043868"' \
		$@ $<
shp/water/tl_2015_22071_areawater-lake-pontchartrain-features.shp: shp/water/tl_2015_22071_areawater-crs.shp
	@# Orleans Parish (071)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "1104492831897"' \
		$@ $<
shp/water/tl_2015_22103_areawater-lake-pontchartrain-features.shp: shp/water/tl_2015_22103_areawater-crs.shp
	@# St. Tammany Parish (103)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "11082011201" OR HYDROID = "1104701918973" OR HYDROID = "1104492833578" OR HYDROID = "11082013688"' \
		$@ $<
shp/water/tl_2015_22105_areawater-lake-pontchartrain-features.shp: shp/water/tl_2015_22105_areawater-crs.shp
	@# Tangipahoa Parish (105)
	@ogr2ogr -f 'ESRI Shapefile' \
		-where 'HYDROID = "1104492831901" OR HYDROID = "1104492833577"' \
		$@ $<

# Merge Mississippi River shapefiles
shp/water/missriver.shp: shp/water/tl_2015_28055_areawater-ms-river-features.shp \
	shp/water/tl_2015_28149_areawater-ms-river-features.shp \
	shp/water/tl_2015_28021_areawater-ms-river-features.shp \
	shp/water/tl_2015_28063_areawater-ms-river-features.shp \
	shp/water/tl_2015_28001_areawater-ms-river-features.shp \
	shp/water/tl_2015_28157_areawater-ms-river-features.shp \
	shp/water/tl_2015_22035_areawater-ms-river-features.shp \
	shp/water/tl_2015_22065_areawater-ms-river-features.shp \
	shp/water/tl_2015_22107_areawater-ms-river-features.shp \
	shp/water/tl_2015_22029_areawater-ms-river-features.shp \
	shp/water/tl_2015_22125_areawater-ms-river-features.shp \
	shp/water/tl_2015_22121_areawater-ms-river-features.shp \
	shp/water/tl_2015_22033_areawater-ms-river-features.shp \
	shp/water/tl_2015_22047_areawater-ms-river-features.shp \
	shp/water/tl_2015_22005_areawater-ms-river-features.shp \
	shp/water/tl_2015_22093_areawater-ms-river-features.shp \
	shp/water/tl_2015_22095_areawater-ms-river-features.shp \
	shp/water/tl_2015_22089_areawater-ms-river-features.shp \
	shp/water/tl_2015_22051_areawater-ms-river-features.shp \
	shp/water/tl_2015_22071_areawater-ms-river-features.shp \
	shp/water/tl_2015_22087_areawater-ms-river-features.shp \
	shp/water/tl_2015_22075_areawater-ms-river-features.shp

	@for file in $^; do ogr2ogr -update -append -nln missriver $@ $$file; done
# Merge Gulf of Mexico shapefiles
shp/water/gulfofmexico.shp: shp/water/tl_2015_22023_areawater-gulf-of-mexico-features.shp \
	shp/water/tl_2015_22113_areawater-gulf-of-mexico-features.shp \
	shp/water/tl_2015_22045_areawater-gulf-of-mexico-features.shp \
	shp/water/tl_2015_22101_areawater-gulf-of-mexico-features.shp \
	shp/water/tl_2015_22109_areawater-gulf-of-mexico-features.shp \
	shp/water/tl_2015_22057_areawater-gulf-of-mexico-features.shp \
	shp/water/tl_2015_22051_areawater-gulf-of-mexico-features.shp \
	shp/water/tl_2015_22075_areawater-gulf-of-mexico-features.shp \
	shp/water/tl_2015_22087_areawater-gulf-of-mexico-features.shp \
	shp/water/tl_2015_22103_areawater-gulf-of-mexico-features.shp \
	shp/water/tl_2015_28045_areawater-gulf-of-mexico-features.shp \
	shp/water/tl_2015_28047_areawater-gulf-of-mexico-features.shp

	@for file in $^; do ogr2ogr -update -append -nln gulfofmexico $@ $$file; done
# Merge Lake Pontchartrain shapefiles
shp/water/lakepontchartrain.shp: shp/water/tl_2015_22095_areawater-lake-pontchartrain-features.shp \
	shp/water/tl_2015_22089_areawater-lake-pontchartrain-features.shp \
	shp/water/tl_2015_22051_areawater-lake-pontchartrain-features.shp \
	shp/water/tl_2015_22071_areawater-lake-pontchartrain-features.shp \
	shp/water/tl_2015_22103_areawater-lake-pontchartrain-features.shp \
	shp/water/tl_2015_22105_areawater-lake-pontchartrain-features.shp

	@for file in $^; do ogr2ogr -update -append -nln lakepontchartrain $@ $$file; done

# Dissolve Mississippi River
exports/shp/water/mississippi-river.shp: shp/water/missriver.shp
	@mkdir -p $(dir $@)
	@ogr2ogr $@ $< -dialect sqlite -sql "SELECT st_union(Geometry) FROM missriver"
# Dissolve Gulf of Mexico
exports/shp/water/gulf-of-mexico.shp: shp/water/gulfofmexico.shp
	@mkdir -p $(dir $@)
	@ogr2ogr $@ $< -dialect sqlite -sql "SELECT st_union(Geometry) FROM gulfofmexico"
# Dissolve Lake Pontchartrain
exports/shp/water/lake-pontchartrain.shp: shp/water/lakepontchartrain.shp
	@mkdir -p $(dir $@)
	@ogr2ogr $@ $< -dialect sqlite -sql "SELECT st_union(Geometry) FROM lakepontchartrain"

# Simplify water geometries
exports/shp/water/%-simplified.shp: exports/shp/water/%.shp
	@mkdir -p $(dir $@)
	@ogr2ogr $@ $< -simplify 0.0003

# Coverting water to GeoJSON
exports/geojson/water/%.json: exports/shp/water/%.shp
	@mkdir -p $(dir $@)
	@rm -f $@
	@ogr2ogr -f GeoJSON $@ $<

# Converting water to TopoJSON
exports/topojson/water/%.json: exports/shp/water/%.shp
	@mkdir -p $(dir $@)
	@topojson -o $@ $< -p

water: exports/shp/water/mississippi-river.shp \
	exports/shp/water/mississippi-river-simplified.shp \
	exports/shp/water/gulf-of-mexico.shp \
	exports/shp/water/gulf-of-mexico-simplified.shp \
	exports/shp/water/lake-pontchartrain.shp \
	exports/shp/water/lake-pontchartrain-simplified.shp \
	exports/geojson/water/mississippi-river.json \
	exports/geojson/water/mississippi-river-simplified.json \
	exports/geojson/water/gulf-of-mexico.json \
	exports/geojson/water/gulf-of-mexico-simplified.json \
	exports/geojson/water/lake-pontchartrain.json \
	exports/geojson/water/lake-pontchartrain-simplified.json \
	exports/topojson/water/mississippi-river.json \
	exports/topojson/water/mississippi-river-simplified.json \
	exports/topojson/water/gulf-of-mexico.json \
	exports/topojson/water/gulf-of-mexico-simplified.json \
	exports/topojson/water/lake-pontchartrain.json \
	exports/topojson/water/lake-pontchartrain-simplified.json

# Cleanup
clean:
	rm -rf geojson
	rm -rf shp
	rm -rf tmp
	rm -rf temp
	rm -rf topojson
