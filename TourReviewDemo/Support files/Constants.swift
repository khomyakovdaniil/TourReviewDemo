//
//  Constants.swift
//  TourReviewDemo
//
//  Created by  Даниил Хомяков on 12.07.2024.
//

import Foundation

struct Constants {
    
    struct StartViewControllerStrings {
       static let button = "Оценить экскурсию"
    }
    
    struct RatingSheetViewStrings {
        static let congratsLabel = "Офигенно, вы дошли до конца! \nРасскажите, как вам?"
        static let generalRate = "Как вам тур в целом?"
        static let guideRate = "Понравился гид?"
        static let infoRate = "Как вам подача информации?"
        static let navigationRate = "Удобная навигация между шагами?"
        static let continueButton = "Далее"
        static let skipAnswerButton = "Не хочу отвечать"
    }
    
    struct CommentSheetViewStrings {
        static let reviewLabel = "Что вам особенно понравилось в этом туре?"
        static let suggestionLabel = "Как мы могли бы улучшить подачу информации?"
        static let placeholderText = "Напишите здесь, чем вам запомнился тур, посоветуете ли его друзьям и как удалось повеселиться"
        static let continueButton = "Сохранить отзыв"
        static let skipAnswerButton = "Пропустить"
    }
}
