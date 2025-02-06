# automaat_app

Mobile app developed for 'mobile app development' course

## Useful websites

Creating reactive icon: https://icon.kitchen
Model generator from json: https://app.quicktype.io/

## Start Ngrok
```
ngrok http 8080 --domain 'domain'.app
```
## Start JHipster
```
./mvnw
```
## Generate Retrofit class && floor database
```
dart run build_runner build
```

## Generate optimized svg
```
dart run vector_graphics_compiler -i assets/foo.svg -o assets/foo.svg.vec
```

## Start MailDev server
```
docker compose -f src/main/docker/maildev.yml up
```