#! /bin/bash
# RCF(b,n,mu,p,i,j) = RCF($1,$2,$3,$4,$5,$6)
mbn=$(bc <<< 'scale='$4';'$1'/(10^'$2'-'$3')')
mbn=$(echo "$mbn" | tr -d '\n \\' )
scf=$(bc <<< 'scale=0 ; ('$mbn'*10^('$4'))/1')
scf=$(echo "$scf" | tr -d '\n \\' )
rcf=$(bc <<< '('$scf'%(10 ^ ('$5' + '$6'))-'$scf'%(10 ^ ('$5')))/10 ^ ('$5')')
rcf=$(echo "$rcf" | tr -d '\n \\' )
echo $rcf
