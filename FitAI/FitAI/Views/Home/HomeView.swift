//
//  HomeView.swift
//  FitAI
//
//  Home view - daily tracking dashboard
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Daily Progress Card
                    if let goal = homeViewModel.dailyGoal {
                        DailyProgressCard(
                            goal: goal,
                            totals: homeViewModel.dailyTotals,
                            remaining: homeViewModel.remainingCalories,
                            isAchieved: homeViewModel.isGoalAchieved,
                            progress: homeViewModel.calorieProgress
                        )
                    }
                    
                    // Macro Breakdown
                    MacroBreakdownCard(macros: homeViewModel.dailyTotals)
                    
                    // Food Entries List
                    FoodEntriesList(entries: homeViewModel.foodEntries)
                }
                .padding()
            }
            .navigationTitle("Today")
            .refreshable {
                await homeViewModel.loadTodayData()
            }
            .task {
                await homeViewModel.loadTodayData()
            }
        }
    }
}

struct DailyProgressCard: View {
    let goal: DailyGoal
    let totals: MacroNutrients
    let remaining: Double
    let isAchieved: Bool
    let progress: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Daily Calories")
                .font(.headline)
            
            // Progress Bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 30)

                    let clampedProgress = progress.isFinite ? min(max(progress, 0), 1) : 0
                    let width = geometry.size.width.isFinite ? geometry.size.width : 0
                    let barWidth = width * CGFloat(clampedProgress)
                    
                    Rectangle()
                        .fill(isAchieved ? Color.green : Color.blue)
                        .frame(width: max(0, barWidth), height: 30)
                }
                .cornerRadius(15)
            }
            .frame(height: 30)
            
            HStack {
                Text("\(Int(totals.calories)) / \(goal.dailyCalorieGoal) cal")
                    .font(.subheadline)
                
                Spacer()
                
                Text("\(Int(remaining)) remaining")
                    .font(.subheadline)
                    .foregroundColor(remaining > 0 ? .blue : .green)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct MacroBreakdownCard: View {
    let macros: MacroNutrients
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Macros")
                .font(.headline)
            
            HStack(spacing: 20) {
                MacroItem(name: "Protein", value: macros.protein, unit: "g", color: .red)
                MacroItem(name: "Carbs", value: macros.carbs, unit: "g", color: .blue)
                MacroItem(name: "Fat", value: macros.fat, unit: "g", color: .yellow)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct MacroItem: View {
    let name: String
    let value: Double
    let unit: String
    let color: Color
    
    var body: some View {
        VStack {
            Text(name)
                .font(.caption)
                .foregroundColor(.secondary)
            Text("\(Int(value))")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(color)
            Text(unit)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

struct FoodEntriesList: View {
    let entries: [FoodEntry]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Food Entries")
                .font(.headline)
            
            if entries.isEmpty {
                Text("No food entries today")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            } else {
                ForEach(entries) { entry in
                    FoodEntryRow(entry: entry)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct FoodEntryRow: View {
    let entry: FoodEntry
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(entry.foodName)
                    .font(.headline)
                Text(entry.mealType.displayName)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text("\(Int(entry.calories)) cal")
                .font(.subheadline)
                .fontWeight(.semibold)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}

