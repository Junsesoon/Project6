## Project6 ###################################################################
# C3조: 오준서, 천성한, 한호종, 황윤수
# 기간: 2021.11.29(월) ~ 2021.12.6(월)

  # 프로젝트 역할분담
  #오준서: 점 차트, 상자 그래프, 변수간의 비교 시각화
  #천성한: 막대 차트, 산점도, 3차원 산점도, 
  #한호종: 원형 차트, 히스토그램, 지도 시각화
  #황윤수: 누적 막대, 중첩자료 시각화, 밀도 그래프

# 환경설정
    # 두번 실행하면 변수 전체 초기화
    all = [var for var in globals() if var[0] != "_"]
    for var in all:
        del globals()[var]

# 라이브러리 모음
import matplotlib.pyplot as plt #그래프 시각화 패키지
from sklearn import datasets #iris 데이터 셋 로딩 패키지
from pandas import DataFrame
import pandas as pd # 데이터 프레임으로 변환 패키지
from matplotlib import font_manager, rc # 한글폰트 사용 패키지
font_path = "C:/Windows/Fonts/malgun.ttf"
font = font_manager.FontProperties(fname=font_path).get_name()
rc('font', family=font)
from sklearn.datasets import load_iris # iris 데이터 가져오기
import numpy as np # 고수학 연산 패키지
import seaborn as sns
from scipy.stats import gaussian_kde


## 1.막대차트(가로,세로) #######################################################
x = (305, 450, 320, 460, 330, 480, 380, 520)
y = ("2018 1분기", "2019 1분기",
                       "2018 2분기", "2019 2분기",
                       "2018 3분기", "2019 3분기",
                       "2018 4분기", "2019 4분기")
plt.bar(x, y)
plt.show()



## 2.막대차트(누적) ############################################################
ba = pd.read_csv('VADeaths.csv')
ba_01 = ba.drop(['Unnamed: 0'],axis=1)
ba_02 = ba_01.transpose()
ba_03 = ba_02.values.tolist()
ba_03
rows = zip(ba_03[0], ba_03[1], ba_03[2])
headers = ['GenderPlace', 'Age', 'Rate']
df = pd.DataFrame(list(rows), columns=headers)
pivot_df = df.pivot(index='GenderPlace', columns='Age', values='Rate')
pivot_df = pivot_df[['50-54', '55-59', '60-64', '65-69', '70-74']].copy()
pivot_df.plot.bar(stacked=True, figsize=(10,7),rot=0)



## 3.점 차트 ###################################################################
# 1) 데이터 생성
chart_data = (305, 450, 320, 460, 330, 480, 380, 520)
chart_quater = ["2018 1분기 ", "2019 1분기",
                "2018 2분기 ", "2019 2분기",
                "2018 3분기 ", "2019 3분기",
                "2018 4분기 ", "2019 4분기"]

# 2) 점 차트 시각화
plt.scatter(chart_data,chart_quater)
plt.title('chart data')




## 4.원형 차트 #################################################################
# 1) 데이터 생성
chart_data1 = {'value': [305, 450, 320, 460, 330, 480, 380, 520],
               '분기': ["2018 1분기", "2019 1분기", "2018 2분기", "2019 2분기", "2018 3분기", "2019 3분기", "2018 4분기", "2019 4분기"]}
chart_dataframe1 = DataFrame(chart_data1)
list1 = list()
for i in range(0, len(chart_dataframe1)):
    list1.append(round(chart_dataframe1['value'][i] / sum(chart_dataframe1['value']) * 100, 1))
chart_dataframe1['ratio'] = list1
chart_dataframe1

# 2) 시각화
colors = ['#ff9999', '#ffc000', '#8fd9b6', '#d395d0']
wedgeprops = {'width': 0.7, 'edgecolor': 'w', 'linewidth': 5}
plt.pie(chart_dataframe1['ratio'], labels=chart_dataframe1['분기'], autopct='%.1f%%', startangle=260, counterclock=False, colors=colors, wedgeprops=wedgeprops)
plt.show()




## 5.상자 그래프 ###############################################################
# 1) VADeaths 데이터 생성
age = ("50-54","55-59","60-64","65-69","70-74")
Rural_Male = (11.7,18.1,26.9,41,66)
RuRal_Female = (8.7,11.7,20.3,30.9,54.3)
Urban_Male = (15.4,24.3,37,54.6,71.1)
Urban_Female = (8.4,13.6,19.3,35.1,50)

# 2) 그래프 양식 지정
plt.style.use('default')

# 3) 시각화
fig, ax = plt.subplots()
ax.boxplot([Rural_Male,RuRal_Female,Urban_Male,Urban_Female])
ax.set_xlabel('category')
ax.set_ylabel('age')
plt.title('VADeaths')
plt.show()




## 6.히스토그램 ################################################################
# 데이터 확인 및 전처리
iris = load_iris() # iris data load
print(iris) # 로드된 데이터가 속성-스타일 접근을 제공하는 딕셔너리와 번치 객체로 표현된 것을 확인
print(iris.DESCR) # Description 속성을 이용해서 데이터셋의 정보를 확인
# 각 key에 저장된 value 확인
# feature
print(iris.data)
print(iris.feature_names)
# label
print(iris.target)
print(iris.target_names)
# feature_names 와 target을 레코드로 갖는 데이터프레임 생성
df = pd.DataFrame(data=iris.data, columns=iris.feature_names)
df['target'] = iris.target
# 0.0, 1.0, 2.0으로 표현된 label을 문자열로 매핑
df['target'] = df['target'].map({0:"setosa", 1:"versicolor", 2:"virginica"})
print(df)

# 시각화
#sepal.length 기준
plt.hist(df.iloc[:,:1], bins=8, label='bins=8')
plt.legend()
plt.show()
#sepal.width 기준
plt.hist(df.iloc[:,1:2], bins=13, label='bins=13')
plt.legend()
plt.show()



## 7.산점도 ####################################################################
x1 = [np.random.randint(100) for _ in range(10) ]
y1 = [1,2,3,4,5,6,7,8,9,10]

plt.scatter(x1, y1)
plt.show()




## 8.중첩자료 시각화 ###########################################################
data = pd.read_csv('galton.csv')

fig, ax = plt.subplots()
for color in ['tab:green']:
    x = data["parent"]
    y = data["child"]
    scale = 300
    ax.scatter(x, y, c=color, s=scale, label=color,
               alpha=0.3)

ax.legend()
ax.grid(True)



## 9.변수간의 비교 시각화 ######################################################
iris = datasets.load_iris()
plt.scatter(iris.data[:,0],iris.data[:,1]) #sepal.length 와 sepal.width 비교
plt.scatter(iris.data[:,2],iris.data[:,3]) #petal.length 와 petal.width 비교




## 10. 밀도 그래프 #############################################################
df = pd.read_csv('iris.csv')
kde = gaussian_kde(df["Sepal.Width"])
X = np.linspace(2, 4.5)
Y = kde(X)
fig, ax = plt.subplots()
hists = ax.hist(df["Sepal.Width"], density=True)
ax.plot(X, Y)
plt.show()



## 11. 3차원 산점도 그래프 #####################################################
iris = sns.load_dataset('iris')

xs = iris[["sepal_length"]]
ys = iris[["sepal_width"]]
zs = iris[["petal_length"]]

fig = plt.figure(figsize=(6, 6))
ax = fig.add_subplot(111, projection='3d')
ax.scatter(xs, ys, zs,  marker='o', s=15, cmap='Greens')



## 12. 지도 시각화 #############################################################



