#dcoker dosyası decker dkonteynerini tam olarak nasıl olsuturdugumuzu açıklıyor, dolaysıyla docker imajı dan bir dcoker koynterner olısturmak için gereken talımatlar

FROM python:3.13.11-slim  
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/
#uv yi iceren docker imaji. odna uv yi alip bin e koyyoz. Bu selişlde olunca uv kullnilabilir hale geliyor. uv ile gucelleiyoz kodları

#mevcut dizine kopyaları atıyoz
WORKDIR /code
ENV PATH="/code/.venv/bin:$PATH"
#uv nin sanal olstrcagı oram burası
#python da burdan gelecek. altta entrpoint iciinne eklemeye gerek kalmıyor


COPY pyproject.toml .python-version uv.lock ./
RUN uv sync --locked   
#uv senkronizasyonunu kilitli olrak çalıstırmak icin


#bak bunları yazdınya uv yı de cektik , sonra terminalden 
#docker build -t test:pandas .
#docker run -it --rm --entrypoint=bash test:pandas
#ls   deyince eklenmiş lacak gerekli seyler

#build edince hızlıda heğpsiniinşa ettipip instal ile yavaş


COPY pipeline.py . 
#("pipeline.py dosyasını şu anki çalışma klasörüme (/code) kopyala" demek).

ENTRYPOINT ["python", "pipeline.py" ]  

#işelmleri otımati yapmak manuel olmamamak için giris python işlem hattı sağda dcoker run yurutulek code yorumlar lar,

#((((docker build -t test:pandas .)))))        =>  sonra bunu tekrar çalıstırdıgımızda onellege  alınmıs  dıyor yroumlar tekrardan calıstırılmayacak test pndas ismini bizveriyoz
#bu docker dosyasinial, docker imajiolustur olusturduhgun seye de test:pandas dadını ve demek


#(((((docker run -it --rm test:pandas 12)))))  => calistir
#docker lastirilmisveri hattimiziolusturduk

