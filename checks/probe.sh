#!/bin/sh
# The SKU search queries the catalogue and renders its Twig page.
curl -fsS --max-time 15 -d 'search=probe' http://web:8081/sku_search.php | grep -q 'href="index.php"'
