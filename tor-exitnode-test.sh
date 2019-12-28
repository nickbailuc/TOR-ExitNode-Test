#!/bin/bash

##  Author = "Nick Bailuc"
##  Copyright = "Copyright (C) 2019 Nick Bailuc, <nick.bailuc@gmail.com>"
##  License = "GNU General Public License, version 3 or later"
##  version = "2.00"
##
##
##  "TOR-ExitNode-Test" (or "TEnT")
##  is free software; you can redistribute it and/or modify
##  it under the terms of the GNU General Public License as published by
##  the Free Software Foundation; either version 3 of the License, or
##  (at your option) any later version.
##
##  TEnT is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU General Public License for more details.
##
##  You should have received a copy of the GNU General Public License
##  along with this program.  If not, see <http://www.gnu.org/licenses/>.


regions=(AF AX AL DZ AS AD AO AI AQ AG AR AM AW AU AT AZ BH BS BD BB BY BE BZ BJ BM BT BO BQ BA BW BV BR IO BN BG BF BI KH CM CA CV KY CF TD CL CN CX CC CO KM CG CD CK CR CI HR CU CW CY CZ DK DJ DM DO EC EG SV GQ ER EE ET FK FO FJ FI FR GF PF TF GA GM GE DE GH GI GR GL GD GP GU GT GG GN GW GY HT HM VA HN HK HU IS IN ID IR IQ IE IM IL IT JM JP JE JO KZ KE KI KP KR KW KG LA LV LB LS LR LY LI LT LU MO MK MG MW MY MV ML MT MH MQ MR MU YT MX FM MD MC MN ME MS MA MZ MM NA NR NP NL NC NZ NI NE NG NU NF MP NO OM PK PW PS PA PG PY PE PH PN PL PT PR QA RE RO RU RW BL SH KN LC MF PM VC WS SM ST SA SN RS SC SL SG SX SK SI SB SO ZA GS SS ES LK SD SR SJ SZ SE CH SY TW TJ TZ TH TL TG TK TO TT TN TR TM TC TV UG UA AE GB US UM UY UZ VU VE VN VG VI WF EH YE ZM ZW)

rm tmp errors 2> /dev/null

echo Forloop in progress...

for iso in ${regions[@]}
do
	printf "	Probing $iso"
	printf '\n'$iso'\n' >> tmp 2>> errors
	timeout --preserve-status 60 tor ExitNodes {$iso} >> tmp 2>> errors
	printf " Done.\n"
done

if [ $? != 0 ]
then
	echo Forloop error: refer to errors file and check if tor is correctly installed
	exit 1
fi

echo Forloop completed. List of ExitNodes which bootstrapped 100%:

echo $(awk -vRS= '/100%/ {print $1}' tmp) && rm tmp errors

exit 0
