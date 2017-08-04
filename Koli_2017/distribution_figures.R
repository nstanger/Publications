# http://www.statmethods.net/advgraphs/layout.html
par(fig = c(0,1,0,0.875), new = FALSE)
hist(marksData[marksData$Year %in% c(2013:2014),]$Mark, breaks = seq(from = 0, to = 100, by = 10), xlab = "Grade (%)", main = "")
par(fig=c(0,1,0.55,1), new = TRUE)
boxplot(marksData[marksData$Year %in% c(2013:2014),]$Mark, horizontal = TRUE, axes = FALSE, ylim = c(0,100))

par(fig = c(0,1,0,0.875), new = FALSE)
hist(marksData[marksData$Year %in% c(2009:2012,2015,2016),]$Mark, breaks = seq(from = 0, to = 100, by = 10), xlab = "Grade (%)", main = "")
par(fig = c(0,1,0.55,1), new = TRUE)
boxplot(marksData[marksData$Year %in% c(2009:2012,2015,2016),]$Mark, horizontal = TRUE, axes = FALSE, ylim = c(0,100))


par(mfrow = c(3,3), mar = c(4, 2, 1, 1), oma = c(2.5, 2.5, 0, 0))
for(i in c(2009:2016))
{
    hist(marksData[marksData$Year == i,]$Mark, breaks = seq(from = 0, to = 100, by = 10), xlab = "", ylab = "", main = "", xaxt = "n")
    axis(1, at = seq(from = 0, to = 100, by = 20), labels = c(0, "", 40, "", 80, ""))
    title(xlab = i, line = 2.3)
}
mtext(side = 1, "Grade (%)", outer = TRUE, line = 0.6)   
mtext(side = 2, "Frequency", outer = TRUE, line = 0.8)   
