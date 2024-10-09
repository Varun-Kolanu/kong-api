#!/bin/bash

if [ -f .env ]; then
  source .env
fi

TARGETS=""

for i in $(seq 1 10); do
  DOMAIN_VAR="DOMAIN$i"
  DOMAIN_VAL=$(eval echo \$$DOMAIN_VAR)
  
  if [ -n "$DOMAIN_VAL" ]; then
    TARGETS="$TARGETS
      - target: $DOMAIN_VAL
        weight: 100"
  fi
done

ESCAPED_TARGETS=$(echo "$TARGETS" | sed ':a;N;$!ba;s/\n/\\n/g')

sed \
  -e "s|{ targets }|$ESCAPED_TARGETS|" \
  -e "s|{DOMAIN[0-9]*}|$DOMAIN1|g" \
  ./kong-template.yml > ./kong.yml