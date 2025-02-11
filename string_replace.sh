set -e
 
function usage () {
    echo -e "\033[32m Usage : \033[0m"
    echo -e "\033[32m ------------------------------------------------------------------- \033[0m"
    echo "|  bash $0 -f [file_path] -o [old_tring] -n [new_string] [OPTION] -i [iter_path]"
    echo "|      Supported options:"
    echo "|             f: input file name."
    echo "|             o: old string to replace."
    echo "|             n: new string."
    echo "|             i: all the file in the path which need to be processed. "
    echo "|                                                   "
    echo "|  eg.1. bash string_replace.sh -f testfile -o ROOT -n root"
    echo "|      which means replace all 'ROOT' to 'root' in testfile."
    echo "|  eg.2. bash string_replace.sh -f testfile -o ROOT -n root -i /data"
    echo "|      which means replace all 'ROOT' to 'root' in all file under the '/data' path."
    echo -e "\033[32m ------------------------------------------------------------------- \033[0m"
}
 
while getopts 'f:o:n:h:i:' opt; do
   case "$opt" in
       h)  usage ; exit 1 ;;
       f)  FILE_PATH=$OPTARG ;;
       o)  OLD_STR=$OPTARG ;;
       n)  NEW_STR=$OPTARG ;;
       i)  DIR_ROOT=$OPTARG ;;
       ?)  echo "unrecognized optional arg : "; $opt; usage; exit 1;;
   esac
done
 
echo "replace all $OLD_STR to $NEW_STR in file $FILE_PATH."
echo "------------------------------------------------------------"
run_cmd_base="sed -i \"s/$OLD_STR/$NEW_STR/g\""
echo "Current PATH is "$DIR_ROOT
if [ ! -z $DIR_ROOT ]; then
  for dir in $DIR_ROOT/*
  do
    if [ -d $dir ]; then
      for net in $dir/*
      do
        if [ -e $net/$FILE_PATH ]; then
           run_cmd="${run_cmd_base} $net/$FILE_PATH"
           echo $run_cmd
           eval $run_cmd
        fi
      done
      if [ -e $dir/$FILE_PATH ]; then
        run_cmd="${run_cmd_base} $dir/$FILE_PATH"
        echo $run_cmd
        eval $run_cmd
      fi
    fi
  done
else
  run_cmd="${run_cmd_base} $FILE_PATH"
  #eval $run_cmd
  echo $run_cmd
fi
