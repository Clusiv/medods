wget https://raw.githubusercontent.com/GreatMedivack/files/master/list.out > /dev/null 2>&1

if [ $# -eq 0 ]; then
    srvname=SRV
else
    srvname=$1
fi

today=$(date +"%d_%m_%Y")

failed_file="${srvname}_${today}_failed.out"
running_file="${srvname}_${today}_running.out"
report_file="${srvname}_${today}_report.out"

grep 'Error\|CrashLoopBackOff' list.out | awk '{ print $1 }' | sed  's/-[[:alnum:]]\{9,10\}-[[:alnum:]]\{5\}$//'  > $failed_file
grep 'Running' list.out | awk '{ print $1 }' | sed  's/-[[:alnum:]]\{9,10\}-[[:alnum:]]\{5\}$//'  > $running_file

report_date=$(date +"%d/%m/%Y")

failed_count=$(wc -l $failed_file | awk '{ print $1 }')
running_count=$(wc -l $running_file | awk '{ print $1 }')

echo "Количество работающих сервисов: $running_count\nКоличество сервисов с ошибками: $failed_count\nИмя системного пользователя: $USER\nДата: $repor>

tarname="${srvname}_${today}.tar.gz"
outfiles="$srvname*out"
tar -czf $tarname --remove-files $outfiles

#gunzip -t SRV_16_12_2020.tar.gz
tar -tzf $tarname

mkdir -p archives
mv $tarname archives/
rm list.out

#if tar -tzf output equal to $*_file?
echo "SUCCESS"
