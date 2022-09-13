(define *path* (cons "./libs" (cons "../" *path*)))

(import (bubo server))
(import (bubo match))
(import (shot template))
(define port 8081)

(define (router request)
  (let* ((path (get request 'path "/"))
         (splitted-route (route path)))
    (CASE splitted-route
          (MATCH ("GET" "images" string?) =>
            (r-type images filename)
            (print "FILENAME: " filename)
            (request-dispatch 'static (string-append "./" images "/" filename) request))
          (MATCH ("GET" string? string?) =>
            (path sth sth2)
            (request-dispatch 'redirect
              "http://google.com"
              request))
          (MATCH ("GET" string?) =>
                 (path name)
                 (request-dispatch 'template 
                      (IMG 
                        (list 
                         (list "src" (string-append "http://0.0.0.0:" (number->string port) "/images/buboMeme.jpeg"))) "")
                    request))
          (else
            (request-dispatch 'template (DIV '() (H1 '() "TEST")) request)))))


(server-start port router)
