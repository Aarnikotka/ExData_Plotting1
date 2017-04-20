#import necessary rows from the unzipped file
el_table<-read.csv('household_power_consumption.txt', skip=62000,nrows = 10000,sep=';',header=FALSE)
#import col names, rename cols of el_table
el_names<-read.csv('household_power_consumption.txt',nrows = 10,sep=';',header=TRUE)
names(el_table)<-names(el_names)
rm(el_names)
#change date format
el_table$Date<-strptime(el_table$Date,'%d/%m/%Y')

#choose only two days in February
el_table<-el_table[el_table$Date>='2007-02-01' & el_table$Date<='2007-02-02',]

#screen device
windows()
hist(el_table$Global_active_power,col='red',xlab='Global Active Power (kilowatts)',
     'main'='Global Active Power')

#png file device
png(file='Plot1.png',width = 480,height = 480)
hist(el_table$Global_active_power,col='red',xlab='Global Active Power (kilowatts)',
     'main'='Global Active Power')
dev.off()

rm(el_table)