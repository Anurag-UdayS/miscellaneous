function getIdx{
	return $(($1 + $2 * 100))
}

function getCenter{
	return $(( ($1 - $2) / 2))
}

str=()
for i in $(seq 1 $((63*100)) ); do
	#echo $i
	str+=( '_' )
done;

echo ${#str[@]}