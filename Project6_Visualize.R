## Project6 ###################################################################
# C3조: 오준서, 천성한, 한호종, 황윤수
# 기간: 2021.11.29(월) ~ 2021.12.2(목)

  # 프로젝트 역할분담
  #오준서: 점 차트, 상자 그래프, 변수간의 비교 시각화
  #천성한: 막대 차트, 산점도, 3차원 산점도, 
  #한호종: 원형 차트, 히스토그램, 지도 시각화
  #황윤수: 누적 막대, 중첩자료 시각화, 밀도 그래프

# 환경설정
rm(list=ls())
getwd()
setwd("C:/rwork")
  # 라이브러리 모음
install.packages("ggplot2")
install.packages("plotly")
install.packages("scatterplot3d")

library(ggplot2)
library(plotly)
library(scatterplot3d)

## 1.막대차트(가로,세로) #######################################################




## 2.막대차트(누적) ############################################################




## 3.점 차트 ###################################################################

# 공통 데이터
chart_data <- c(305, 450, 320, 460, 330, 480, 380, 520)
names(chart_data) <- c("2018 1분기 ", "2019 1분기",
                       "2018 2분기 ", "2019 2분기",
                       "2018 3분기 ", "2019 3분기",
                       "2018 4분기 ", "2019 4분기")
# 자료형 변환
point_df <- data.frame(chart_data,names(chart_data))


# graphics 패키지를 이용한 시각화
dotchart(chart_data, color = c("blue", "red"),
         lcolor = "black", pch = 1:2,
         labels = names(chart_data),
         xlab = "매출액",
         main = "분기별 판매현황: 점차트 시각화",cex = 1.2)


# ggplot2 패키지를 이용한 시각화
ggplot(data = point_df,aes(x = chart_data, y = names.chart_data.)) + geom_point()

# plotly 패키지를 이용한 시각화
plot_ly(data = point_df, x = ~chart_data, y = ~names.chart_data., type = 'scatter')




## 4.원형 차트 #################################################################
##데이터
chart_data <- c(305, 450, 320, 460, 330, 480, 380, 520)
names(chart_data) <- c("2018 1분기", "2019 1분기",
                       "2018 2분기", "2019 2분기", 
                       "2018 3분기", "2019 3분기", 
                       "2018 4분기", "2019 4분기")
str(chart_data)
chart_data
##ggplot2
str(chart_data)
class(chart_data)
chart_data.f <- as.data.frame(chart_data)
sum(chart_data)
chart_data[1]
length(chart_data)
x = integer()
for(x in 1:length(chart_data)){
  chart_data.f$pct[x] = round(chart_data[x] / sum(chart_data) * 100, digits = 2)
}
rownames(chart_data.f)
chart_data.f
ggplot(chart_data.f, aes(x="", y=chart_data.f$pct, fill=rownames(chart_data.f))) + 
  geom_bar(stat="identity", color=NA) + theme_void() + coord_polar(theta="y") + 
  geom_text(aes(label=paste0(round(pct,1), '%')), position=position_stack(vjust=0.5)) + 
  ggtitle("2018~2019년도 분기별 매출현황") + labs(fill = "년도 분기")
##plotly
USPersonalExpenditure <- data.frame("Categorie"=rownames(USPersonalExpenditure), USPersonalExpenditure)
data <- USPersonalExpenditure[,c('Categorie', 'X1960')]
fig <- plot_ly(data, labels = ~Categorie, values = ~X1960, type = 'pie')
fig <- fig %>% layout(title = 'United States Personal Expenditures by Categories in 1960',
                      xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                      yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
fig #https://plotly.com/r/pie-charts/

CHART_data <- data.frame("Categorie"=names(chart_data), chart_data)
fig1 <- plot_ly(CHART_data, labels = ~Categorie, values = ~chart_data, type = 'pie')
fig1 <- fig1 %>% layout(title = "2018~2019년도 분기별 매출현황")
fig1


## 5.상자 그래프 ###############################################################

# 공통 데이터
data("VADeaths")

# graphics 패키지를 이용한 시각화
# 1) 시각화
boxplot(VADeaths, range = 0)
boxplot(VADeaths, range = 0, notch = T)
# 2) 중심선 추가
abline(h = 37, lty = 3, col = "red")


# ggplot2 패키지를 이용한 시각화
# 1) 자료형 변환
VAD <- as.data.frame.table(VADeaths)
colnames(VAD) = c("age","category","Freq")
# 2) 시각화
ggplot(VAD,aes(x = category, y = Freq)) +
  geom_boxplot()


# plotly 패키지를 이용한 시각화
# 1) 자료형 변환
a <- as.data.frame(VADeaths)
# 2) 시각화
plot_ly(a,x=VAD$category,y=VAD$Freq,type = 'box')




## 6.히스토그램 ################################################################
##데이터
data(iris); names(iris); str(iris); head(iris)
##ggplot2
summary(iris$Sepal.Length) #Sepal.Length 기준 히스토그램 시각화
ggplot(iris, aes(x = Sepal.Length)) + geom_histogram() + 
  ggtitle("iris 꽃 받침 길이 Histogram")
ggplot(iris, aes(x = Sepal.Length)) + geom_histogram(binwidth = 0.1) + 
  ggtitle("iris 꽃 받침 길이 Histogram binwidth 0.1")
ggplot(iris, aes(x = Sepal.Length)) + geom_histogram(binwidth = 0.5) + 
  ggtitle("iris 꽃 받침 길이 Histogram binwidth 0.5")
summary(iris$Sepal.Width) #Sepal.Width 기준 히스토그램 시각화
ggplot(iris, aes(x = Sepal.Width)) + geom_histogram(binwidth = 0.1) + 
  ggtitle("iris 꽃 받침 너비 Histogram binwidth 0.1")
ggplot(iris, aes(x = Sepal.Width)) + geom_histogram(binwidth = 0.2) + 
  ggtitle("iris 꽃 받침 너비 Histogram binwidth 0.2")

ggplot(iris, aes(x = Sepal.Width)) + geom_histogram(binwidth = 0.2) + 
  ggtitle("iris 꽃 받침 너비 Histogram binwidth 0.2") #빈도수 히스토그램
ggplot(iris, aes(x = Sepal.Width)) + geom_density() +
  ggtitle("iris 꽃 받침 너비 밀도 곡선") #밀도 곡선
ggplot(iris, aes(x = Sepal.Width, fill = Species, col = Species)) + geom_density(alpha = 0.2) +
  ggtitle("iris 꽃 받침 너비 밀도 곡선") #종별 각각 밀도 곡선
##plotly
fig2 <- plot_ly(data = iris, x = iris$Sepal.Length, type = "histogram")
fig2 <- fig2 %>% layout(title = "iris 꽃 받침 길이 Histogram")
fig2
fig2 <- plot_ly(data = iris, x = iris$Sepal.Width, type = "histogram")
fig2 <- fig2 %>% layout(title = "iris 꽃 받침 너비 Histogram")
fig2



## 7.산점도 ####################################################################




## 8.중첩자료 시각화 ###########################################################




## 9.변수간의 비교 시각화 ######################################################

# 공통 데이터
data(iris)

# graphics 패키지를 이용한 비교 시각화
attributes(iris)
pairs(iris[iris$Species == "versicolor", 1:4])
pairs(iris[iris$Species == "virginica", 1:4])
pairs(iris[iris$Species == "setosa", 1:4])

# ggplot2(ggpairs) 패키지를 이용한 비교 시각화
ggpairs(iris, columns = colnames(iris))




## 10. 밀도 그래프 #############################################################




## 11. 3차원 산점도 그래프 #####################################################




## 12. 지도 시각화 #############################################################
library(plotly)
#install.packages("ggmap")
library(ggmap)
pop <- read.csv('C:/Rwork/dataset3/population201901.csv', header = T)
library(stringr)
region <- pop$'지역명'
lon <- pop$LON
lat <- pop$LAT
tot_pop <- as.numeric(str_replace_all(pop$'총인구수', ',', ''))
df <- data.frame(region, lon, lat, tot_pop)
df <- df[1:17, ]
df
gmap <- list(
  scope = 'asia',
  showland = TRUE,
  landcolor = toRGB("gray95"),
  subunitcolor = toRGB("gray85"),
  countrycolor = toRGB("gray85"),
  countrywidth = 0.5,
  subunitwidth = 0.5
)
gmap2 <- c(
  gmap,
  resolution = 50,
  showcoastlines = T,
  countrycolor = toRGB("white"),
  coastlinecolor = toRGB("white"),
  projection = list(type = 'Mercator'),
  list(lonaxis = list(range = c(123, 133))),
  list(lataxis = list(range = c(32, 40))),
  list(domain = list(x = c(0, 1), y = c(0, 1)))
)
fig3 <- plot_geo(df, lat = ~lat, lon = ~lon)
fig3 <- fig3 %>% add_markers(
  text = ~paste(region, paste(tot_pop, "명"), sep = "<br />"),
  color = ~tot_pop, symbol = I("circle"), size = I(50), hoverinfo = "text"
)
fig3 <- fig3 %>% colorbar(title = "인구수")
fig3 <- fig3 %>% layout(
  title = "2019년도 1월 대한민국 인구수", geo = gmap2
)
fig3
#https://plotly.com/r/choropleth-maps/


