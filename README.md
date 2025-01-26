# automaat_app

Mobile app developed for 'mobile app development' course

## Used websites

Creating reactive icon: https://icon.kitchen
Model generator from json: https://app.quicktype.io/

## Start Ngrok
```
ngrok http 8080 --domain talented-loving-llama.ngrok-free.app
```
## Start JHipster
```
./mvnw
```
## Generate Retrofit class && floor database
```
dart pub run build_runner build
```

## Generate optimized svg
```
dart run vector_graphics_compiler -i assets/foo.svg -o assets/foo.svg.vec
```