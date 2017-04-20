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

#as weekday names in my system are not in english, need additional code
weekdays_vec<-c('Mon','Tue','Wed','Thu','Fri','Sat','Sun')
el_table$weekday<-weekdays_vec[(el_table$Date)$wday]

#to make x tick labels as required, need to know how many unique dates in our table
un_dates<-unique(el_table$Date)
#now we need to get rows number, where dates change
row_vector<-1
for (i_date in 2:length(un_dates))
        row_vector<-c(row_vector,min(which(el_table$Date==un_dates[i_date])))
#get weekday names according to row numbers
x_tick_lab<-el_table$weekday[row_vector]
#additional point is needed for x tick labeling
row_vector<-c(row_vector,dim(el_table)[1]+1)
x_tick_lab<-c(x_tick_lab,weekdays_vec[(function(x){if (x==8) {1} else{x}})((tail(un_dates,1))$wday+1)])
rm(weekdays_vec,un_dates,i_date)

#screen device
windows()
par(mfrow=c(2,2))
plot(el_table$Global_active_power,xaxt='n',ylab='Global Active Power',type='l',xlab='')
axis(1, at=row_vector, labels=x_tick_lab)

plot(el_table$Voltage,xaxt='n',ylab='Voltage',type='l',xlab='datetime')
axis(1, at=row_vector, labels=x_tick_lab)

plot(el_table$Sub_metering_1,xaxt='n',ylab='Energy sub metering',type='l',xlab='',col='black')
lines(el_table$Sub_metering_2,col='red')
lines(el_table$Sub_metering_3,col='blue')
axis(1, at=row_vector, labels=x_tick_lab)
legend('topright',lty=c(1,1,1),lwd=c(2,2,2),col=c('black','red','blue'),
       legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))

plot(el_table$Global_reactive_power,ylab='Global_reactive_power',xaxt='n',type='l',xlab='datetime')
axis(1, at=row_vector, labels=x_tick_lab)

#png file device
png(file='Plot4.png',width = 480,height = 480)
par(mfrow=c(2,2))
plot(el_table$Global_active_power,xaxt='n',ylab='Global Active Power',type='l',xlab='')
axis(1, at=row_vector, labels=x_tick_lab)

plot(el_table$Voltage,xaxt='n',ylab='Voltage',type='l',xlab='datetime')
axis(1, at=row_vector, labels=x_tick_lab)

plot(el_table$Sub_metering_1,xaxt='n',ylab='Energy sub metering',type='l',xlab='',col='black')
lines(el_table$Sub_metering_2,col='red')
lines(el_table$Sub_metering_3,col='blue')
axis(1, at=row_vector, labels=x_tick_lab)
legend('topright',lty=c(1,1,1),lwd=c(2,2,2),col=c('black','red','blue'),
       legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))

plot(el_table$Global_reactive_power,ylab='Global_reactive_power',xaxt='n',type='l',xlab='datetime')
axis(1, at=row_vector, labels=x_tick_lab)
dev.off()

rm(row_vector,x_tick_lab,el_table)