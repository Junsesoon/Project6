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
install.packages("GGally") # 변수간 비교: ggpairs()
install.packages("dplyr") # 파이프 연산자
install.packages("reshape2") # 데이터 핸들링: melt()
install.packages("UsingR")
install.packages("HistData") # Usingr 부속 패키지
install.packages("Hmisc") # UsingR 부속 패키지
install.packages("ggmap")
install.packages("stringr")

library(ggplot2)
library(plotly)
library(scatterplot3d)
library(GGally)
library(dplyr)
library(reshape2)
library(UsingR)
library(ggmap)
library(stringr)


## 1.막대차트(가로,세로) #######################################################

## 공통 데이터
chart_data <- c(305, 450, 320, 460, 330, 480, 380, 520)
names(chart_data) <- c("2018 1분기","2019 1분기","2018 2분기",
                       "2019 2분기","2018 3분기","2019 3분기",
                       "2018 4분기","2019 4분기")
str(chart_data)
chart_data

## graphics 패키지를 이용한 시각화
# 1) 세로 막대 차트 그리기
barplot(chart_data, ylim = c(0, 600),
        ylab = "매출액 단위 : 만원",  # 레이블 추가
        xlab = "년도별 분기 현황",
        col = rainbow(8),  # 색상 지정
        main = "2018 년도 vs 2019 년도 매출현항 비교")

# 2) 가로 막대 차트 그리기
barplot(chart_data, xlim = c(0, 600), horiz = T,
        ylab = "매출액(단위: 만원)",
        xlab = "년도별 분기 현황",
        col = rainbow(8), space = 1, cex.names = 0.8,  # 막대 사이 간격 조정
        main = "2018 년도 vs 2019 년도 매출현항 비교")
col = rep(c("red", "green"), 4)  # 막대 색상 지정


## ggplot2 패키지를 이용한 시각화
# 1) 세로 막대 차트 그리기
# 1-1) 자료형 변환
chart_df <- as.data.frame(chart_data)

# 1-2) 시각화
chart.bar <- ggplot(data=chart_df) + aes(x=rownames(chart_df),y=chart_data) +
  geom_bar(stat = "identity"); chart.bar

# 2) 가로 막대 차트 그리기
chart.bar + coord_flip()


## plotly 패키지를 이용한 시각화
# 1) 세로 막대 차트 그리기
chart_df %>% 
  plot_ly() %>% 
  add_trace(x = rownames(chart_df), y = chart_data , type = "bar") %>% 
  layout(
    title = "plotly 세로 막대 그래프",
    xaxis = list(title = "분기"),
    yaxis = list(title = "chart data")
  )

# 2) 가로 막대 차트 그리기
chart_df %>% 
  plot_ly() %>% 
  add_trace(x = chart_data, y = rownames(chart_df), type = "bar") %>% 
  layout(
    title = "plotly 세로 막대 그래프",
    xaxis = list(title = "분기"),
    yaxis = list(title = "chart data")
  )



## 2.막대차트(누적) ############################################################

# 공통 데이터
data("VADeaths")
VADeaths
VAD.ly <- melt(VADeaths)
colnames(VAD.ly) <- c("age","category","value")

# graphics 패키지를 이용한 시각화
barplot(VADeaths, beside = F, col = rainbow(5))
title(main="미국 버지니아주 하위계층 사망비율",font.main=4)
legend(3.8, 200, c("50-54","55-59","60-64","65-69","70-74"),
       cex = 0.8, fill = rainbow(5))


# ggplot2 패키지를 이용한 시각화
ggplot(VAD.ly, aes(fill=age, y=value, x=Var2)) + 
  geom_bar(position="stack", stat="identity")


# plotly 패키지를 이용한 시각화
VAD.ly %>% as.data.frame() %>% 
  plot_ly() %>% 
  add_trace(x = ~Var2, y = ~value, color= ~age,  type = "bar") %>% 
  layout(
    title = "미국 버지니아주 하위계층 사망비율",
    xaxis = list(title = "category"),
    yaxis = list(title = "누적 비율"),
    barmode = "stack"
  )




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
fig

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

# 공통 데이터
price <- runif(10,min=1,max=100)
plot(price,col= 'red')
data1 <- as.data.frame(price)
no <- c(1:10)
data2 <- data.frame(data1,no)
data2


#ggplot2
ggplot(data2, aes(x=no, y=price)) +  geom_point(shape=15, size=3, colour="blue")


#plotly 산점도
plot_ly(data2 ,type='scatter', x=~no, y=~price)




## 8.중첩자료 시각화 ###########################################################

# 공통 데이터
data(galton)

# graphics 패키지를 이용한 비교 시각화
galtonData <- as.data.frame(table(galton$child, galton$parent))
head(galtonData)
names(galtonData) = c("child", "parent", "freq")
head(galtonData)
parent <- as.numeric(galtonData$parent)
child <- as.numeric(galtonData$child)
par(mfrow = c(1, 1))
plot(parent, child,
     pch = 21, col = "blue", bg = "green", cex = 0.2 * galtonData$freq,
     xlab = "parent", ylab = "child")


# ggplot2 패키지를 이용한 비교 시각화
freqData <- data.frame(table(galton$child, galton$parent))
names(freqData) <- c("child", "parent", "freq")

g <- ggplot(data=freqData, aes(x = parent, y = child))+ 
  scale_size(range = c(1,7), guide = 'none')  +
  geom_point(colour="grey10", aes(size=freq)) ;g


# plotly 패키지를 이용한 비교 시각화
ga_pl <- plot_ly(galton, 
                 x = ~child , y = ~parent,
                 color = ~child , size = ~child)
ga_pl


## 9.변수간의 비교 시각화 ######################################################

# 공통 데이터
data(iris)

# graphics 패키지를 이용한 비교 시각화
attributes(iris)
pairs(iris[iris$Species == "versicolor", 1:4])
pairs(iris[iris$Species == "virginica", 1:4])
pairs(iris[iris$Species == "setosa", 1:4])

# ggplot2(GGally) 패키지를 이용한 비교 시각화
ggpairs(iris, columns = colnames(iris))




## 10. 밀도 그래프 #############################################################

# 공통 데이터

# graphics 패키지를 이용한 비교 시각화
par(mfrow = c(1, 1))
hist(iris$Sepal.Width, xlab = "iris$Sepal.Width", col = "mistyrose",
     freq = F, main = "iris 꽃받침 너비", xlim = c(2.0, 4.5))
lines(density(iris$Sepal.Width), col = "red")
x <- seq(2.0, 4.5, 0.1)
curve(dnorm(x, mean = mean(iris$Sepal.Width),
            sd = sd(iris$Sepal.Width)), col = "mistyrose", add = T)


# ggplot2 패키지를 이용한 비교 시각화
density <- ggplot(data=iris, aes(x=Sepal.Width))
density + geom_histogram(binwidth=0.2, color="black", fill="mistyrose", aes(y=..density..)) +
  geom_density(stat="density", alpha=I(0.2), fill="mistyrose") +
  xlab("Sepal Width") +  ylab("Density") + ggtitle("Histogram & Density Curve")


# plotly 패키지를 이용한 비교 시각화
gg <- ggplot(iris,aes(x = Sepal.Width, color = 'density')) +  
  geom_histogram(aes(y = ..density..), bins = 12,  fill = 'mistyrose', alpha = 0.5) +  
  geom_density(color = 'black') +  
  geom_rug(color = 'mistyrose') + 
  ylab("") + 
  xlab("")  + theme(legend.title=element_blank()) +
  scale_color_manual(values = c('density' = 'black'))

ggplotly(gg)%>% 
  layout(xaxis = list(   
    title='Sepal Width', 
    zerolinecolor = 'gray',   
    zerolinewidth = 2,   
    gridcolor = 'black'),   
    yaxis = list(   
      title='Density', 
      zerolinecolor = 'gray',   
      zerolinewidth = 2,   
      gridcolor = 'black'))




## 11. 3차원 산점도 그래프 #####################################################

# scatterplot3d 패키지를 이용한 시각화
iris_setosa = iris[iris$Species == 'setosa', ]
iris_versicolor = iris[iris$Species == 'versicolor', ]
iris_virginica = iris[iris$Species == 'virginica', ]
# 3차원 틀(Frame)생성하기
d3 <- scatterplot3d(iris$Petal.Length, 
                    iris$Sepal.Length,
                    iris$Sepal.Width, 
                    type = 'n')
# 3차원 산점도 시각화
d3$points3d(iris_setosa$Petal.Length,
            iris_setosa$Sepal.Length,
            iris_setosa$Sepal.Width, 
            bg = 'orange', pch = 21)
d3$points3d(iris_versicolor$Petal.Length, 
            iris_versicolor$Sepal.Length,
            iris_versicolor$Sepal.Width,
            bg = 'blue', pch = 23)
d3$points3d(iris_virginica$Petal.Length, 
            iris_virginica$Sepal.Length,
            iris_virginica$Sepal.Width, 
            bg = 'green', pch = 25)


# plotly 패키지를 이용한 시각화
p1 <- plot_ly(iris, x = iris$Sepal.Length,
              y = iris$Sepal.Width,
              z = iris$Petal.Length,
              color = iris$Species)
p1


## 12. 지도 시각화 #############################################################
pop <- read.csv('C:/Rwork/dataset3/population201901.csv', header = T)
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



