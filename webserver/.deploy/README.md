## self certificate

```
export SSL_C="AT"
export SSL_ST="VIENNA"
export SSL_O="Webfux - Solutions 4 Web"
export SSL_CN="webfux.io"

openssl req -x509 -nodes -days 365 -subj "/C=$SSL_A/ST=$SSL_ST/O=$SSL_O/CN=$SSL_CN" -addext "subjectAltName=DNS:$SSL_CN" -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
openssl req -x509 -nodes -days 365 -subj "/C=AT/ST=VIENNA/O=Webfux - Solutions 4 Web/CN=webfux.io" -addext "subjectAltName=DNS:webfux.io" -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
openssl req -x509 -nodes -days 365 -subj "/C=AT/ST=VIENNA/O=Webfux - Solutions 4 Web/CN=webfux.io" -addext "subjectAltName=DNS:webfux.io" -newkey rsa:2048 -keyout /etc/ssl/private/webfux.io.key -out /etc/ssl/certs/webfux.io.crt
openssl x509 req -days 365 -subj "/C=AT/ST=VIENNA/O=Webfux - Solutions 4 Web/CN=webfux.io" -addext "subjectAltName=DNS:webfux.io" -newkey rsa:2048 -keyout /etc/ssl/private/webfux.io.key -out /etc/ssl/certs/webfux.io.crt
```