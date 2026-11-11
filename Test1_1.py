def count_friday_13th(week_of_1jan):
    # Количество дней в каждом месяце
    days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

    count = 0
    # День недели, на который приходится 1-е число текущего месяца
    current_day = week_of_1jan

    # Проверяем каждое 13-е число месяца
    for days in days_in_month:
        # 13-е число — это 1-е число + 12 дней
        if (current_day + 12) % 7 == 4:  # пятница = 4 (пн=0, вт=1, ср=2, чт=3, пт=4)
            count += 1
        # Переходим к 1-му числу следующего месяца
        current_day = (current_day + days) % 7

    return count