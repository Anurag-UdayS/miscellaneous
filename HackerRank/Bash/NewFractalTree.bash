freq=16
read degree

function drop() {
    output
    while [[ "${igap}" != "_" ]]; do
        igap=$(printf "_%.0s" $(seq 1 $((${#igap} - 2)) ))
        pad=$pad"_"
        gap=$gap"__"        
        output
    done
    
    pad=$pad"_"
    gap=$gap"__"
    update
    if [[ $degree -gt 1 ]]; then output; fi
}

function update() {
    degree=$(( degree-1 ))
    evaluate
}

function output() {
    if [[ $degree -le 0 ]]; then return 0; fi
    printf $pad
    if [[ $freq -gt 1 ]]; then printf "1${igap}1${gap}%.0s" $(seq 2 $freq ); fi
    printf "1${igap}1_$pad\n"
}

function blankOut() {
    for (( i=0; i < $aval; i++ )) {
        echo "____________________________________________________________________________________________________"     
    }
}

function evaluate() {
    deginv=$((5-$degree))
    aval=`echo "(2^($deginv+1))-1" | bc`
    igap=$( printf "_%.0s" $( seq 1 $aval ) )
    gap=$igap
    freq=`echo "2^($degree - 1)" | bc`
    
    temp=`echo "17+(2^$deginv)" | bc`
    pad=$( printf "_%.0s" $( seq 1 $temp ) )
}


evaluate
blankOut

while [[ $degree -gt 0 ]]; do
    n=`echo "(2^($deginv)-1)" | bc`
    if [[ n -lt 1 ]]; then n=0; fi
     
    drop
    for _ in $(seq 1 $n); do output; done
    if [[ $degree -eq 1 ]]; then output; fi
done

printf "${pad}1_${pad}\n%.0s" $(seq 1 16)