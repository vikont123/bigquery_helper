-- bigest table in public data 
SELECT  project_id,  dataset_id, table_id, row_count,
  ROUND(size_bytes/pow(10,9),2) as size_gb,
  TIMESTAMP_MILLIS(creation_time) AS creation_time,
  TIMESTAMP_MILLIS(last_modified_time) as last_modified_time,
  CASE
    WHEN type = 1 THEN 'table'
    WHEN type = 2 THEN 'view'
  ELSE NULL
  END AS type
FROM   `bigquery-public-data.ecmwf_era5_reanalysis.ar-era5-v0`
 
-- table with 56PB data - bigquery-public-data.ecmwf_era5_reanalysis.ar-era5-v0  <<< The Bigest table in bigquery-public-data   -- :) select * will be cost ~344K$

-------- 20 bigest tables in US
WITH _tbl AS (
  SELECT * FROM `bigquery-public-data.baseball.__TABLES__` UNION ALL
  SELECT * FROM `bigquery-public-data.bls.__TABLES__` UNION ALL
  SELECT * FROM `bigquery-public-data.census_bureau_usa.__TABLES__` UNION ALL
  SELECT * FROM `bigquery-public-data.cloud_storage_geo_index.__TABLES__` UNION ALL
  SELECT * FROM `bigquery-public-data.cms_codes.__TABLES__` UNION ALL
  SELECT * FROM `bigquery-public-data.fec.__TABLES__` UNION ALL
  SELECT * FROM `bigquery-public-data.genomics_cannabis.__TABLES__` UNION ALL
  SELECT * FROM `bigquery-public-data.ghcn_d.__TABLES__` UNION ALL
  SELECT * FROM `bigquery-public-data.ghcn_m.__TABLES__` UNION ALL
  SELECT * FROM `bigquery-public-data.github_repos.__TABLES__` UNION ALL
  SELECT * FROM `bigquery-public-data.hacker_news.__TABLES__` UNION ALL
  SELECT * FROM `bigquery-public-data.irs_990.__TABLES__` UNION ALL
  SELECT * FROM `bigquery-public-data.medicare.__TABLES__` UNION ALL
  SELECT * FROM `bigquery-public-data.new_york.__TABLES__` UNION ALL
  SELECT * FROM `bigquery-public-data.nlm_rxnorm.__TABLES__` UNION ALL
  SELECT * FROM `bigquery-public-data.noaa_gsod.__TABLES__` UNION ALL
  SELECT * FROM `bigquery-public-data.open_images.__TABLES__` UNION ALL
  SELECT * FROM `bigquery-public-data.samples.__TABLES__` UNION ALL
  SELECT * FROM `bigquery-public-data.san_francisco.__TABLES__` UNION ALL
  SELECT * FROM `bigquery-public-data.stackoverflow.__TABLES__` UNION ALL
  SELECT * FROM `bigquery-public-data.usa_names.__TABLES__` UNION ALL
  SELECT * FROM `bigquery-public-data.worldpop.__TABLES__` UNION ALL
SELECT * FROM `bigquery-public-data.wikipedia.__TABLES__` UNION ALL
SELECT * FROM `bigquery-public-data.gbif.__TABLES__` UNION ALL
SELECT * FROM `bigquery-public-data.genomics_rice.__TABLES__` UNION ALL
SELECT * FROM `bigquery-public-data.gbif.__TABLES__` UNION ALL
SELECT * FROM `bigquery-public-data.google_ads.__TABLES__` UNION ALL
SELECT * FROM `bigquery-public-data.crypto_ethereum.__TABLES__` UNION ALL
  SELECT * FROM `bigquery-public-data.utility_us.__TABLES__`
)
SELECT
  project_id, dataset_id, table_id, row_count,
  ROUND(size_bytes/pow(10,9),2) as size_gb,
  TIMESTAMP_MILLIS(creation_time) AS creation_time,
  TIMESTAMP_MILLIS(last_modified_time) as last_modified_time,
  CASE
    WHEN type = 1 THEN 'table'
    WHEN type = 2 THEN 'view'
  ELSE NULL
  END AS type
FROM _tbl
ORDER BY row_count DESC, size_gb DESC
LIMIT 20;

-----


---- all "bigquery_public_data" datasets 
bq ls --max_results=1000 --project_id=bigquery-public-data

america_health_rankings                         
austin_311                                      
austin_bikeshare                                
austin_crime                                    
austin_incidents                                
austin_waste                                    
baseball                                        
bbc_news                                        
bigqueryml_ncaa                                 
bitcoin_blockchain                              
blackhole_database                              
blockchain_analytics_ethereum_mainnet_us        
bls                                             
bls_qcew                                        
breathe                                         
broadstreet_adi                                 
catalonian_mobile_coverage                      
catalonian_mobile_coverage_eu                   
census_bureau_acs                               
census_bureau_construction                      
census_bureau_international                     
census_bureau_usa                               
census_opportunity_atlas                        
census_utility                                  
cfpb_complaints                                 
chicago_crime                                   
chicago_taxi_trips                              
clemson_dice                                    
cloud_storage_geo_index                         
cms_codes                                       
cms_medicare                                    
cms_synthetic_patient_data_omop                 
country_codes                                   
covid19_aha                                     
covid19_covidtracking                           
covid19_ecdc                                    
covid19_ecdc_eu                                 
covid19_genome_sequence                         
covid19_geotab_mobility_impact                  
covid19_geotab_mobility_impact_eu               
covid19_google_mobility                         
covid19_google_mobility_eu                      
covid19_govt_response                           
covid19_italy                                   
covid19_italy_eu                                
covid19_jhu_csse                                
covid19_jhu_csse_eu                             
covid19_nyt                                     
covid19_open_data                               
covid19_open_data_eu                            
covid19_public_forecasts                        
covid19_public_forecasts_asia_ne1               
covid19_rxrx19                                  
covid19_symptom_search                          
covid19_tracking                                
covid19_usafacts                                
covid19_vaccination_access                      
covid19_vaccination_search_insights             
covid19_weathersource_com                       
crypto_aptos_mainnet_us                         
crypto_aptos_testnet_us                         
crypto_band                                     
crypto_bitcoin                                  
crypto_bitcoin_cash                             
crypto_dash                                     
crypto_dogecoin                                 
crypto_ethereum                                 
crypto_ethereum_classic                         
crypto_iotex                                    
crypto_kusama                                   
crypto_litecoin                                 
crypto_multiversx_mainnet_eu                    
crypto_near_mainnet_us                          
crypto_polkadot                                 
crypto_polygon                                  
crypto_solana_mainnet_us                        
crypto_sui_mainnet_us                           
crypto_tezos                                    
crypto_theta                                    
crypto_zcash                                    
crypto_zilliqa                                  
cymbal_investments                              
dataflix_covid                                  
dataflix_traffic_safety                         
deepmind_alphafold                              
deps_dev_v1                                     
dimensions_ai_covid19                           
ebi_chembl                                      
ebi_mgnify                                      
ebi_surechembl                                  
eclipse_megamovie                               
ecmwf_era5_reanalysis                           
epa_historical_air_quality                      
ethereum_blockchain                             
etsi_technical_standards                        
faa                                             
fcc_political_ads                               
fda_drug                                        
fda_food                                        
fdic_banks                                      
fec                                             
fhir_synthea                                    
ga4_obfuscated_sample_ecommerce                 
gbif                                            
gdelt_hathitrustbooks                           
gdelt_internetarchivebooks                      
genomics_cannabis                               
genomics_rice                                   
geo_census_blockgroups                          
geo_census_tracts                               
geo_international_ports                         
geo_openstreetmap                               
geo_us_boundaries                               
geo_us_census_places                            
geo_us_roads                                    
geo_whos_on_first                               
ghcn_d                                          
ghcn_m                                          
github_repos                                    
gnomAD                                          
gnomAD_asiane1                                  
gnomAD_eu                                       
goog_blockchain_arbitrum_one_us                 
goog_blockchain_avalanche_contract_chain_us     
goog_blockchain_cronos_mainnet_us               
goog_blockchain_ethereum_goerli_us              
goog_blockchain_ethereum_mainnet_us             
goog_blockchain_fantom_opera_us                 
goog_blockchain_optimism_mainnet_us             
goog_blockchain_polygon_mainnet_us              
goog_blockchain_tron_mainnet_us                 
google_ads                                      
google_ads_geo_mapping_asia_east1               
google_ads_geo_mapping_asia_east2               
google_ads_geo_mapping_asia_northeast1          
google_ads_geo_mapping_asia_northeast2          
google_ads_geo_mapping_asia_northeast3          
google_ads_geo_mapping_asia_south1              
google_ads_geo_mapping_asia_south2              
google_ads_geo_mapping_asia_southeast1          
google_ads_geo_mapping_asia_southeast2          
google_ads_geo_mapping_australia_southeast1     
google_ads_geo_mapping_australia_southeast2     
google_ads_geo_mapping_eu                       
google_ads_geo_mapping_europe_central2          
google_ads_geo_mapping_europe_north1            
google_ads_geo_mapping_europe_southwest1        
google_ads_geo_mapping_europe_west1             
google_ads_geo_mapping_europe_west12            
google_ads_geo_mapping_europe_west2             
google_ads_geo_mapping_europe_west3             
google_ads_geo_mapping_europe_west4             
google_ads_geo_mapping_europe_west6             
google_ads_geo_mapping_europe_west8             
google_ads_geo_mapping_europe_west9             
google_ads_geo_mapping_me_central1              
google_ads_geo_mapping_me_central2              
google_ads_geo_mapping_me_west1                 
google_ads_geo_mapping_northamerica_northeast1  
google_ads_geo_mapping_northamerica_northeast2  
google_ads_geo_mapping_southamerica_east1       
google_ads_geo_mapping_southamerica_west1       
google_ads_geo_mapping_us                       
google_ads_geo_mapping_us_central1              
google_ads_geo_mapping_us_central2              
google_ads_geo_mapping_us_east1                 
google_ads_geo_mapping_us_east4                 
google_ads_geo_mapping_us_east5                 
google_ads_geo_mapping_us_south1                
google_ads_geo_mapping_us_west1                 
google_ads_geo_mapping_us_west2                 
google_ads_geo_mapping_us_west3                 
google_ads_geo_mapping_us_west4                 
google_ads_transparency_center                  
google_analytics_sample                         
google_books_ngrams_2020                        
google_cfe                                      
google_cloud_release_notes                      
google_dei                                      
google_patents_research                         
google_political_ads                            
google_trends                                   
gretel_synthetic_text_to_sql                    
grid_ac                                         
hacker_news                                     
hud_zipcode_crosswalk                           
human_genome_variants                           
human_variant_annotation                        
idc_current                                     
idc_current_clinical                            
idc_v1                                          
idc_v10                                         
idc_v11                                         
idc_v11_clinical                                
idc_v12                                         
idc_v12_clinical                                
idc_v13                                         
idc_v13_clinical                                
idc_v14                                         
idc_v14_clinical                                
idc_v15                                         
idc_v15_clinical                                
idc_v16                                         
idc_v16_clinical                                
idc_v17                                         
idc_v17_clinical                                
idc_v18                                         
idc_v18_clinical                                
idc_v19                                         
idc_v19_clinical                                
idc_v2                                          
idc_v3                                          
idc_v4                                          
idc_v5                                          
idc_v6                                          
idc_v7                                          
idc_v8                                          
idc_v9                                          
imdb                                            
immune_epitope_db                               
iowa_liquor_sales                               
iowa_liquor_sales_forecasting                   
irs_990                                         
labeled_patents                                 
libraries_io                                    
listenbrainz                                    
london_bicycles                                 
london_crime                                    
london_fire_brigade                             
marec                                           
medicare                                        
ml_datasets                                     
ml_datasets_uscentral1                          
modis_terra_net_primary_production              
moon_phases                                     
multilingual_spoken_words_corpus                
nasa_wildfire                                   
national_water_model                            
ncaa_basketball                                 
nces_ipeds                                      
new_york                                        
new_york_311                                    
new_york_citibike                               
new_york_mv_collisions                          
new_york_subway                                 
new_york_taxi_trips                             
new_york_trees                                  
nhtsa_traffic_fatalities                        
nih_gudid                                       
nih_sequence_read                               
nlm_rxnorm                                      
noaa_global_forecast_system                     
noaa_goes16                                     
noaa_goes17                                     
noaa_gsod                                       
noaa_historic_severe_storms                     
noaa_hurricanes                                 
noaa_icoads                                     
noaa_lightning                                  
noaa_nwm                                        
noaa_passive_acoustic_index                     
noaa_passive_bioacoustic                        
noaa_pifsc_metadata                             
noaa_preliminary_severe_storms                  
noaa_significant_earthquakes                    
noaa_tsunami                                    
nppes                                           
nrel_nsrdb                                      
open_buildings                                  
open_images                                     
open_targets_genetics                           
open_targets_platform                           
openaq                                          
overture_maps                                   
patents                                         
patents_cpc                                     
patents_dsep                                    
patents_view                                    
persistent_udfs                                 
properati_properties_ar                         
properati_properties_br                         
properati_properties_cl                         
properati_properties_co                         
properati_properties_mx                         
properati_properties_pe                         
properati_properties_uy                         
pypi                                            
samples                                         
san_francisco                                   
san_francisco_311                               
san_francisco_bikeshare                         
san_francisco_film_locations                    
san_francisco_neighborhoods                     
san_francisco_sffd_service_calls                
san_francisco_sfpd_incidents                    
san_francisco_transit_muni                      
san_francisco_trees                             
sdoh_bea_cainc30                                
sdoh_cdc_wonder_natality                        
sdoh_cms_dual_eligible_enrollment               
sdoh_hrsa_shortage_areas                        
sdoh_hud_housing                                
sdoh_hud_pit_homelessness                       
sdoh_snap_enrollment                            
sec_quarterly_financials                        
stackoverflow                                   
sunroof_solar                                   
the_general_index                               
the_met                                         
thelook_ecommerce                               
ucb_fung_patent_data                            
umiami_lincs                                    
un_sdg                                          
us_res_real_est_data                            
usa_contagious_disease                          
usa_names                                       
usda_nass_agriculture                           
usfs_fia                                        
usitc_investigations                            
uspto_oce_assignment                            
uspto_oce_cancer                                
uspto_oce_claims                                
uspto_oce_litigation                            
uspto_oce_office_actions                        
uspto_oce_pair                                  
uspto_ptab                                      
utility_eu                                      
utility_us                                      
wikipedia                                       
wise_all_sky_data_release                       
world_bank_global_population                    
world_bank_health_population                    
world_bank_intl_debt                            
world_bank_intl_education                       
world_bank_wdi                                  
worldbank_wdi                                   
worldpop   