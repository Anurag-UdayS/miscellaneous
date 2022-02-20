function getIdx {
	# X,Y
	echo $(($1 + ( ($2 - 1) * 100) ))
}

read -r ITER

len=16
pointerXArr=( $((100 / 2)) )
pointerY=63

str=()
o=''

for i in $(seq 1 $((63*100)) ); do
	str+=( '_' )
done;

for _ in $(seq 1 $ITER); do

	for _ in $(seq 1 $len); do
		for pointerX in ${pointerXArr[@]}; do
			idx=$(getIdx $pointerX $pointerY)
			#echo "Indices: $idx For: [${pointerXArr[@]}] $pointerY"
			str[idx]='1'

		done;
		pointerY=$(( $pointerY - 1 ))
	done;

	newX=()
	for pointerX in ${pointerXArr[@]}; do
		_pointerY=$pointerY
		for offsetX in $(seq 1 $len); do
			idx1=`getIdx $(( $pointerX + $offsetX )) $_pointerY`
			idx2=`getIdx $(( $pointerX - $offsetX )) $_pointerY`
			#echo "Indices: $idx1 $idx2 For: $pointerX[${pointerXArr[@]}] $pointerY"
			str[idx1]='1'
			str[idx2]='1'
			_pointerY=$(( $_pointerY - 1 ))
		done;
		newX+=($(( $pointerX + $len )) $(( $pointerX - $len )) )
	done;
	pointerXArr=( ${newX[@]} )
	pointerY=$_pointerY

	len=$(( $len / 2 ))

done;

s=$(seq 1 100)

for y in $(seq 1 63); do
	for x in ${s[@]}; do
		o="$o${str[`getIdx $x $y`]}"
		#echo "For indices $x $y: `getIdx $x $y`"
	done;
	o="$o\n"
done;

echo -e $o