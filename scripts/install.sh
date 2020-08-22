rm Pharo.*
rm Pharo7*
rm -Rf pharo-local
curl https://get.pharo.org/64/70 | bash
curl https://get.pharo.org/64/vm70 | bash
./pharo Pharo.image -st --save --quit install.st

