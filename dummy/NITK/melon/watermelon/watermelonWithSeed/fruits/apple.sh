mkdir apples
cd apples
echo "1 apple a day keeps the doctor away"> apple1.txt
for i in {2..100}
do
	echo "$i apples a day keeps the doctor away"> apple$i.txt
done
for i in {1..100}
do
	mv apple$i.txt kiwi$i.txt
done

