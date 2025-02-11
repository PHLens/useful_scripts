word_docs=`find . -name "*.docx"`
for file in $word_docs;do
    output="${file%.docx}.md"  # Remove .docx and add .md
    pandoc "$file" -o "$output" --extract-media=.
    if [[ $? -eq 0 ]];then
      echo "Successful generate $output."
      rm -rf $file
    else
      echo "Convert failed!"
    fi
done
