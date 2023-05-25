mkdir apples
cd apples
for n in {1..100}
do
	filename="apple$n.txt"
	if ((n==1));
	then
		echo "$n apple a day keeps the doctor away." > "$filename"
	else
		echo "$n apples a day keep the doctor away." > "$filename"
	fi
done

for n in {1..100}
do
	fn1="apple$n.txt"
	fn2="kiwi$n.txt"
	mv "$fn1" "$fn2"
done

cd ..
