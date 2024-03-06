//
//  HKWorkoutActivityType+Extension.swift
//  HealthKitDemo
//
//  Created by Roberto Manese on 2/13/24.
//

import Foundation
import HealthKit

extension HKWorkoutActivityType {
    
    /*
     Simple mapping of available workout types to a human readable name.
     */
    var title: String {
        switch self {
        case .americanFootball:             return "American Football"
        case .archery:                      return "Archery"
        case .australianFootball:           return "Australian Football"
        case .badminton:                    return "Badminton"
        case .baseball:                     return "Baseball"
        case .basketball:                   return "Basketball"
        case .bowling:                      return "Bowling"
        case .boxing:                       return "Boxing"
        case .climbing:                     return "Climbing"
        case .crossTraining:                return "Cross Training"
        case .curling:                      return "Curling"
        case .cycling:                      return "Cycling"
        case .dance:                        return "Dance"
        case .danceInspiredTraining:        return "Dance Inspired Training"
        case .elliptical:                   return "Elliptical"
        case .equestrianSports:             return "Equestrian Sports"
        case .fencing:                      return "Fencing"
        case .fishing:                      return "Fishing"
        case .functionalStrengthTraining:   return "Functional Strength Training"
        case .golf:                         return "Golf"
        case .gymnastics:                   return "Gymnastics"
        case .handball:                     return "Handball"
        case .hiking:                       return "Hiking"
        case .hockey:                       return "Hockey"
        case .hunting:                      return "Hunting"
        case .lacrosse:                     return "Lacrosse"
        case .martialArts:                  return "Martial Arts"
        case .mindAndBody:                  return "Mind and Body"
        case .mixedMetabolicCardioTraining: return "Mixed Metabolic Cardio Training"
        case .paddleSports:                 return "Paddle Sports"
        case .play:                         return "Play"
        case .preparationAndRecovery:       return "Preparation and Recovery"
        case .racquetball:                  return "Racquetball"
        case .rowing:                       return "Rowing"
        case .rugby:                        return "Rugby"
        case .running:                      return "Running"
        case .sailing:                      return "Sailing"
        case .skatingSports:                return "Skating Sports"
        case .snowSports:                   return "Snow Sports"
        case .soccer:                       return "Soccer"
        case .softball:                     return "Softball"
        case .squash:                       return "Squash"
        case .stairClimbing:                return "Stair Climbing"
        case .surfingSports:                return "Surfing Sports"
        case .swimming:                     return "Swimming"
        case .tableTennis:                  return "Table Tennis"
        case .tennis:                       return "Tennis"
        case .trackAndField:                return "Track and Field"
        case .traditionalStrengthTraining:  return "Traditional Strength Training"
        case .volleyball:                   return "Volleyball"
        case .walking:                      return "Walking"
        case .waterFitness:                 return "Water Fitness"
        case .waterPolo:                    return "Water Polo"
        case .waterSports:                  return "Water Sports"
        case .wrestling:                    return "Wrestling"
        case .yoga:                         return "Yoga"
            
            // iOS 10
        case .barre:                        return "Barre"
        case .coreTraining:                 return "Core Training"
        case .crossCountrySkiing:           return "Cross Country Skiing"
        case .downhillSkiing:               return "Downhill Skiing"
        case .flexibility:                  return "Flexibility"
        case .highIntensityIntervalTraining:    return "High Intensity Interval Training"
        case .jumpRope:                     return "Jump Rope"
        case .kickboxing:                   return "Kickboxing"
        case .pilates:                      return "Pilates"
        case .snowboarding:                 return "Snowboarding"
        case .stairs:                       return "Stairs"
        case .stepTraining:                 return "Step Training"
        case .wheelchairWalkPace:           return "Wheelchair Walk Pace"
        case .wheelchairRunPace:            return "Wheelchair Run Pace"
            
            // iOS 11
        case .taiChi:                       return "Tai Chi"
        case .mixedCardio:                  return "Mixed Cardio"
        case .handCycling:                  return "Hand Cycling"
            
            // iOS 13
        case .discSports:                   return "Disc Sports"
        case .fitnessGaming:                return "Fitness Gaming"
            
            // Catch-all
        default:                            return "Other"
        }
    }
    
    /*
     Additional mapping for common name for activity types where appropriate.
     */
    var commonName: String {
        switch self {
        case .highIntensityIntervalTraining: return "HIIT"
        default: return title
        }
    }
    
    /*
     Mapping of available activity types to emojis, where an appropriate gender-agnostic emoji is available.
     */
    var associatedEmoji: String? {
        switch self {
        case .americanFootball:             return "🏈"
        case .archery:                      return "🏹"
        case .badminton:                    return "🏸"
        case .baseball:                     return "⚾️"
        case .basketball:                   return "🏀"
        case .bowling:                      return "🎳"
        case .boxing:                       return "🥊"
        case .curling:                      return "🥌"
        case .cycling:                      return "🚲"
        case .equestrianSports:             return "🏇"
        case .fencing:                      return "🤺"
        case .fishing:                      return "🎣"
        case .functionalStrengthTraining:   return "💪"
        case .golf:                         return "⛳️"
        case .hiking:                       return "🥾"
        case .hockey:                       return "🏒"
        case .lacrosse:                     return "🥍"
        case .martialArts:                  return "🥋"
        case .mixedMetabolicCardioTraining: return "❤️"
        case .paddleSports:                 return "🛶"
        case .rowing:                       return "🛶"
        case .rugby:                        return "🏉"
        case .sailing:                      return "⛵️"
        case .skatingSports:                return "⛸"
        case .snowSports:                   return "🛷"
        case .soccer:                       return "⚽️"
        case .softball:                     return "🥎"
        case .tableTennis:                  return "🏓"
        case .tennis:                       return "🎾"
        case .traditionalStrengthTraining:  return "🏋️‍♂️"
        case .volleyball:                   return "🏐"
        case .waterFitness, .waterSports:   return "💧"
            
            // iOS 10
        case .barre:                        return "🥿"
        case .crossCountrySkiing:           return "⛷"
        case .downhillSkiing:               return "⛷"
        case .kickboxing:                   return "🥋"
        case .snowboarding:                 return "🏂"
            
            // iOS 11
        case .mixedCardio:                  return "❤️"
            
            // iOS 13
        case .discSports:                   return "🥏"
        case .fitnessGaming:                return "🎮"
            
            // Catch-all
        default:                            return nil
        }
    }
    
    enum EmojiGender {
        case male
        case female
    }
    
    /*
     Mapping of available activity types to appropriate gender specific emojies.
     
     If a gender neutral symbol is available this simply returns the value of `associatedEmoji`.
     */
    func associatedEmoji(for gender: EmojiGender) -> String? {
        switch self {
        case .climbing:
            switch gender {
            case .female:                   return "🧗‍♀️"
            case .male:                     return "🧗🏻‍♂️"
            }
        case .dance, .danceInspiredTraining:
            switch gender {
            case .female:                   return "💃"
            case .male:                     return "🕺🏿"
            }
        case .gymnastics:
            switch gender {
            case .female:                   return "🤸‍♀️"
            case .male:                     return "🤸‍♂️"
            }
        case .handball:
            switch gender {
            case .female:                   return "🤾‍♀️"
            case .male:                     return "🤾‍♂️"
            }
        case .mindAndBody, .yoga, .flexibility:
            switch gender {
            case .female:                   return "🧘‍♀️"
            case .male:                     return "🧘‍♂️"
            }
        case .preparationAndRecovery:
            switch gender {
            case .female:                   return "🙆‍♀️"
            case .male:                     return "🙆‍♂️"
            }
        case .running:
            switch gender {
            case .female:                   return "🏃‍♀️"
            case .male:                     return "🏃‍♂️"
            }
        case .surfingSports:
            switch gender {
            case .female:                   return "🏄‍♀️"
            case .male:                     return "🏄‍♂️"
            }
        case .swimming:
            switch gender {
            case .female:                   return "🏊‍♀️"
            case .male:                     return "🏊‍♂️"
            }
        case .walking:
            switch gender {
            case .female:                   return "🚶‍♀️"
            case .male:                     return "🚶‍♂️"
            }
        case .waterPolo:
            switch gender {
            case .female:                   return "🤽‍♀️"
            case .male:                     return "🤽‍♂️"
            }
        case .wrestling:
            switch gender {
            case .female:                   return "🤼‍♀️"
            case .male:                     return "🤼‍♂️"
            }
            
            // Catch-all
        default:                            return associatedEmoji
        }
    }
    
    // SFSymbol
    var symbolName: String {
        switch self {
        case .americanFootball:
            return "sportscourt.fill"
        case .archery:
            return "arrow.and.bow"
        case .australianFootball:
            return "sportscourt.fill"
        case .badminton:
            return "badminton"
        case .baseball:
            return "sportscourt.fill"
        case .basketball:
            return "sportscourt.fill"
        case .bowling:
            return "bowling"
        case .boxing:
            return "sportscourt.fill"
        case .climbing:
            return "figure.walk"
        case .cricket:
            return "sportscourt.fill"
        case .crossTraining:
            return "sportscourt.fill"
        case .curling:
            return "sportscourt.fill"
        case .cycling:
            return "bicycle"
        case .dance:
            return "music.note"
        case .danceInspiredTraining:
            return "music.note"
        case .elliptical:
            return "elliptical.fill"
        case .equestrianSports:
            return "horse"
        case .fencing:
            return "sword"
        case .fishing:
            return "bolt.heart.fill"
        case .functionalStrengthTraining:
            return "figure.strengthtraining.functional"
        case .golf:
            return "sportscourt.fill"
        case .gymnastics:
            return "sportscourt.fill"
        case .handball:
            return "sportscourt.fill"
        case .hiking:
            return "map.fill"
        case .hockey:
            return "sportscourt.fill"
        case .hunting:
            return "bolt.heart.fill"
        case .lacrosse:
            return "sportscourt.fill"
        case .martialArts:
            return "sportscourt.fill"
        case .mindAndBody:
            return "heart.text.square.fill"
        case .mixedMetabolicCardioTraining:
            return "sportscourt.fill"
        case .paddleSports:
            return "paddle"
        case .play:
            return "gamecontroller.fill"
        case .preparationAndRecovery:
            return "timer"
        case .rowing:
            return "rowing"
        case .rugby:
            return "sportscourt.fill"
        case .running:
            return "figure.walk"
        case .sailing:
            return "sailboat.fill"
        case .skatingSports:
            return "sportscourt.fill"
        case .snowSports:
            return "snow"
        case .soccer:
            return "sportscourt.fill"
        case .softball:
            return "sportscourt.fill"
        case .squash:
            return "sportscourt.fill"
        case .stairClimbing:
            return "staircase"
        case .surfingSports:
            return "surfboard"
        case .swimming:
            return "drop.fill"
        case .tableTennis:
            return "tabletennis"
        case .tennis:
            return "sportscourt.fill"
        case .trackAndField:
            return "sportscourt.fill"
        case .traditionalStrengthTraining:
            return "figure.strengthtraining.traditional"
        case .volleyball:
            return "sportscourt.fill"
        case .walking:
            return "figure.walk"
        case .waterFitness:
            return "drop.fill"
        case .waterPolo:
            return "sportscourt.fill"
        case .waterSports:
            return "drop.fill"
        case .wrestling:
            return "sportscourt.fill"
        case .yoga:
            return "person.crop.circle.fill"
        case .barre:
            return "hare.fill"
        case .coreTraining:
            return "figure.core.training"
        case .crossCountrySkiing:
            return "tram.fill"
        case .downhillSkiing:
            return "tram.fill"
        case .flexibility:
            return "figure.flexibility"
        case .highIntensityIntervalTraining:
            return "flame.fill"
        case .jumpRope:
            return "figure.jumprope"
        case .kickboxing:
            return "sportscourt.fill"
        case .pilates:
            return "person.fill"
        case .snowboarding:
            return "snow"
        case .stairs:
            return "staircase"
        case .stepTraining:
            return "figure.walk"
        case .wheelchairWalkPace:
            return "figure.walk"
        case .wheelchairRunPace:
            return "figure.walk"
        case .taiChi:
            return "person.crop.circle.fill"
        case .mixedCardio:
            return "sportscourt.fill"
        case .handCycling:
            return "bicycle"
        case .discSports:
            return "sportscourt.fill"
        case .fitnessGaming:
            return "gamecontroller.fill"
        case .cardioDance:
            return "music.note"
        case .socialDance:
            return "music.note"
        case .pickleball:
            return "sportscourt.fill"
        case .cooldown:
            return "timer"
        case .other:
            return "questionmark.circle.fill"
        case .racquetball:
            return "figure.racquetball"
        case .swimBikeRun:
            return "figure.pool.swim"
        case .transition:
            return "questionmark.circle.fill"
        case .underwaterDiving:
            return "figure.pool.swim"
        default:
            return "questionmark.circle.fill"
        }
    }
}
