import sys
import pandas as pd


print('arguments', sys.argv)#cıktıyı alterminalde  aldıkbunu parametreleştirmekce belirliay için işleyelim

month = int(sys.argv[1])  #1.demek  herzman komut dosyaısnın adıdır, 2.ise parametreler ile alakalı. Vede burda biir tamsayı bekliyoz


df = pd.DataFrame({"day": [1, 2], "num_passengers": [3, 4]})
df['month'] = month
print(df.head())    #bunlar birişlem hattı dwğil girdimizin bu ay oldugunu varwayıp veri işleme yaoıyozsonra pakete kaydediyoz




print('hello pipeline')
#oncelikle birişlem  hattıkurmamız gerekiyor

df.to_parquet(f"output_{month}.parquet")   #pakete kaıt

print(f'hello pipeline, month = {month}')   #termibalde python pipeline.py 12   dersek :  """#arguments ['pipeline.py', '12']
                     #hello pipeline
                     #hello pipeline, month = 12"""    çıktı budur. işlem hattı 12 ye eşiyt olıuyor

#poyrow
#uv   yuksledik sanalortamı yonetir
#uv algortması ile farklı python surumu yukluyoz iniyt  olan kısıım 3.13  bu sanalordamda 3 ya da 13 .surume sahipolamk ısterim demek
#wich  ile bu sisteme pythonun oluyor -V işle ontrol

# uv run python pipeline.py 12 :   bunu dersen solda dosya oluşturuyorırrr. Bunu plıuyrumakiçin sanalortamda p okunukullnıyor



