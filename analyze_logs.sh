#!/bin/bash

LOG_FILE="access.log"
REPORT_FILE="report.txt"

TOTAL_REQUESTS=$(wc -l < "$LOG_FILE")
UNIQUE_IPS=$(awk '{print $1}' "$LOG_FILE" | sort | uniq | wc -l)
TYPES_REQUESTS=$(awk '{print $6}' "$LOG_FILE" | sort | uniq -c | sed 's/"//g')
POPULAR_URL=$(awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 1)

{
  echo "Отчет о логе веб-сервера"
  echo "========================"
  echo ""
  echo "Общее количество запросов: $TOTAL_REQUESTS"
  echo ""
  echo "Количество уникальных IP-адресов: $UNIQUE_IPS"
  echo ""
  echo "Количество запросов по методам:"
  echo "-------------------------------"
  echo "$TYPES_REQUESTS" | awk '{print "Метод: " $2 ", Количество: " $1}'
  echo ""
  echo "Самый популярный URL:"
  echo "---------------------"
  echo "$POPULAR_URL" | awk '{print "URL: " $2 ", Количество запросов: " $1}'
  echo ""
} > "$REPORT_FILE"

echo "Отчет сохранен в файл $REPORT_FILE"