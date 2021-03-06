area = 55
tempArea = 296
currentMOH = data.frame(cases = melt(dengueData2013[area,][,3:54])$value, 
                        temperature = melt(temperatureData2013[tempArea,][,3:54])$value
                        #                        rainfall = melt(rainfallData2013[301,][,2:53])$value
                        #dehiwala = melt(dengueData2013[55,][,3:54])$value, 
                        #colomboMOH = melt(dengueData2013[181,][,3:54])$value, 
                        #                        kolonnawa = melt(dengueData2013[142,][,3:54])$value, 
                        #                       kaduwela = melt(dengueData2013[111,][,3:54])$value, 
                        #moratuwaMOH = melt(dengueData2013[200,][,3:54])$value
                        #                      kaduwela = melt(dengueData2013[235,][,3:54])$value
)
#...................................................................#

# Add columns
currentMOH$lastWeekCases = c(dengueData2014[area,][3:54]$`52`, currentMOH$cases[1:51])
currentMOH$casesLag2[3:52] = c(currentMOH$cases[1:50])
#currentMOH$casesLag3[4:52] = c(currentMOH$cases[1:49])
#currentMOH$casesLag4[5:52] = c(currentMOH$cases[1:48])
#currentMOH$colomboMOHLag1[2:52] = c(melt(dengueData2013[181,][,3:54])$value[1:51])
currentMOH$colomboMOHLag2[3:52] = c(melt(dengueData2013[181,][,3:54])$value[1:50])
#currentMOH$colomboMOHLag3[4:52] = c(melt(dengueData2013[181,][,3:54])$value[1:49])
#currentMOH$colomboMOHLag4[5:52] = c(melt(dengueData2013[181,][,3:54])$value[1:48])
#currentMOH$moratuwaMOHLag1[2:52] = c(melt(dengueData2013[200,][,3:54])$value[1:51])
#currentMOH$moratuwaMOHLag1[3:52] = c(melt(dengueData2013[200,][,3:54])$value[1:50])
#currentMOH$moratuwaMOHLag1[4:52] = c(melt(dengueData2013[200,][,3:54])$value[1:49])
#currentMOH$moratuwaMOHLag1[5:52] = c(melt(dengueData2013[200,][,3:54])$value[1:48])


currentMOH$tempLag1[2:52] = c(currentMOH$temperature[1:51])
currentMOH$tempLag2[3:52] = c(currentMOH$temperature[1:50])
currentMOH$tempLag3[4:52] = c(currentMOH$temperature[1:49])
currentMOH$tempLag4[5:52] = c(currentMOH$temperature[1:48])
currentMOH$tempLag5[6:52] = c(currentMOH$temperature[1:47])
#currentMOH$tempLag6[7:52] = c(currentMOH$temperature[1:46])
#currentMOH$tempLag7[8:52] = c(currentMOH$temperature[1:45])
#currentMOH$tempLag8[9:52] = c(currentMOH$temperature[1:44])

for(i in 1:ncol(currentMOH)){
  currentMOH[is.na(currentMOH[,i]), i] <- mean(currentMOH[,i], na.rm = TRUE)
}
#...................................................................#

data = data.frame(week = c(1:52), actualCases = as.numeric(unCleanedDengueData2013[55,][3:54]), cleanedCases = as.numeric(cleanedDengueData2013[55,][3:54]))
dmelt = melt(data, id = "week")

ggplot(data = dmelt, 
       aes(x = week, y = value, color = variable)) +
  xlab("Week") +
  ylab("Incidences") +
  theme(axis.ticks.y = element_blank(), axis.text.y = element_blank()) +
  geom_line() +
  scale_fill_discrete(name="",
                      breaks=c("actualCases", "cleanedCases"),
                      labels=c("Actual Data", "Cleaned Data")) +
  ggtitle("Dengue Incidences 2013 - Dehiwala MOH")




# Read all the data
#dengueData2013 = fread("/media/suchira/0A9E051F0A9E051F/CSE 2012/Semester 07-08/FYP/Denguenator/Dengunator 2.0/Data/Dengue/dengueCases2013.csv", data.table = F, header = F, col.names = c("id", "MOH_name", c(1:52), "Total"))
dengueData2013 = fread("data/cleanedDengueData2013.csv", data.table = F, header = T, col.names = c("id", "MOH_name", c(1:52), "Total"))
temperatureData2013 = fread("/media/suchira/0A9E051F0A9E051F/CSE 2012/Semester 07-08/FYP/Denguenator/Dengunator 2.0/Data/Met_data/temp/temp.csv", data.table = F, header = T)
rainfallData2013 = fread("rainfall2013.csv", data.table = F, header = T, col.names = c("MOH_name", c(1:52)))
write.csv(x = rainfallData2013, file = "rainfall2013.csv", sep = ",", row.names = FALSE, col.names = TRUE)

dengueData2014 = fread("data/cleanedDengueData2014.csv", data.table = F, header = T, col.names = c("id", "MOH_name", c(1:52), "Total"))
#...................................................................#

# Combining 2013 and 2014
dengueData2013_2014 = data.frame(dengueData2013[1:54],dengueData2014[3:54])
colnames(dengueData2013_2014) <- c("id", "MOH_name", c(1:104))
dengueData2013_2014$Total = rowSums(dengueData2013_2014[3:106])

# Chose a specific MOH
area = 55
tempArea = 296
currentMOH = data.frame(cases = melt(dengueData2013_2014[area,][,3:106])$value, 
                        temperature = melt(temperatureData2013[tempArea,][,3:54])$value
#                        rainfall = melt(rainfallData2013[301,][,2:53])$value
)
#...................................................................#

# On 2013_2014 data
# Chose a specific MOH
currentMOH$lastWeekCases = c((currentMOH$cases[1] + currentMOH$cases[53])/2, currentMOH$cases[1:103])
currentMOH$casesLag2 = c((currentMOH$cases[2:1] + currentMOH$cases[54:53])/2, currentMOH$cases[1:102])
#currentMOH$casesLag3 = c((currentMOH$cases[3:1] + currentMOH$cases[55:53])/2, currentMOH$cases[1:101])
currentMOH$casesLag4 = c((currentMOH$cases[4:1] + currentMOH$cases[56:53])/2, currentMOH$cases[1:100])
currentMOH$colomboMOHLag1 = c(as.numeric(dengueData2013_2014[181,][,3] + dengueData2013_2014[181,][,55])/2, 
                              as.numeric(dengueData2013_2014[181,][,3:105]))
currentMOH$colomboMOHLag2 = c(as.numeric(dengueData2013_2014[181,][,4:3] + dengueData2013_2014[181,][,56:55])/2, 
                              melt(dengueData2013_2014[181,][,3:106])$value[1:102])
currentMOH$colomboMOHLag3 = c(as.numeric(dengueData2013_2014[181,][,5:3] + dengueData2013_2014[181,][,57:55])/2, 
                              melt(dengueData2013_2014[181,][,3:106])$value[1:101])
#currentMOH$colomboMOHLag4 = c(as.numeric(dengueData2013_2014[181,][,6:3] + dengueData2013_2014[181,][,58:55])/2, 
#                              melt(dengueData2013_2014[181,][,3:106])$value[1:100])
currentMOH$moratuwaMOHLag1 = c(as.numeric(dengueData2013_2014[200,][,3] + dengueData2013_2014[200,][,55])/2, 
                               melt(dengueData2013_2014[200,][,3:106])$value[1:103])
#currentMOH$moratuwaMOHLag2 = c(as.numeric(dengueData2013_2014[200,][,4:3] + dengueData2013_2014[200,][,56:55])/2, 
#                               melt(dengueData2013_2014[200,][,3:106])$value[1:102])
#currentMOH$moratuwaMOHLag3 = c(as.numeric(dengueData2013_2014[200,][,5:3] + dengueData2013_2014[200,][,57:55])/2, 
#                               melt(dengueData2013_2014[200,][,3:106])$value[1:101])
#currentMOH$moratuwaMOHLag4 = c(as.numeric(dengueData2013_2014[200,][,6:3] + dengueData2013_2014[200,][,58:55])/2, 
#                               melt(dengueData2013_2014[200,][,3:106])$value[1:100])


#currentMOH$tempLag1 = c(currentMOH$temperature[52], currentMOH$temperature[1:51])
currentMOH$tempLag2 = c(currentMOH$temperature[51:52], currentMOH$temperature[1:50])
#currentMOH$tempLag3 = c(currentMOH$temperature[50:52],currentMOH$temperature[1:49])
#currentMOH$tempLag4 = c(currentMOH$temperature[49:52],currentMOH$temperature[1:48])
#currentMOH$tempLag5 = c(currentMOH$temperature[48:52],currentMOH$temperature[1:47])
#currentMOH$tempLag6 = c(currentMOH$temperature[47:52],currentMOH$temperature[1:46])
#currentMOH$tempLag7 = c(currentMOH$temperature[46:52],currentMOH$temperature[1:45])
currentMOH$tempLag8 = c(currentMOH$temperature[45:52],currentMOH$temperature[1:44])
#...................................................................#
