#!/bin/bash

# All our Varriables
#Top Temperatures varrying between 21 - 27oC
London_top=$((RANDOM % 8 + 20))
Manchester_top=$((RANDOM % 8 + 20))
Birmingham_top=$((RANDOM % 8 + 20))
Newcastle_top=$((RANDOM % 8 + 20))
Liverpool_top=$((RANDOM % 8 + 20))
Nottingham_top=$((RANDOM % 8 + 20))

#Low Temperatures varrying between 16 - 21oC
London_low=$((RANDOM % 7 + 15))
Manchester_low=$((RANDOM % 7 + 15))
Birmingham_low=$((RANDOM % 7 + 15))
Newcastle_low=$((RANDOM % 7 + 15))
Liverpool_low=$((RANDOM % 7 + 15))
Nottingham_low=$((RANDOM % 7 + 15))

#UK Temperatures (average)
total_top_temp=$((London_top + Manchester_top + Birmigham_top + Newcastle_top + Liverpool_top + Nottingham_top))
total_low_temp=$((London_low + Manchester_low + Birmigham_low + Newcastle_low + Liverpool_low + Nottingham_low))
uk_top_temp=$((total_top_temp / 6))
uk_low_temp=$((total_low_temp / 6))
echo "$uk_top_temp "
echo "$uk_low_temp "


