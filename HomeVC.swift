//
//  HomeVC.swift
//  Beyond Fit
//
//  Created by Andrew on 30/09/2021.
//

import UIKit
import SideMenu

class HomeVC: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var fullBodyButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK:- Properties
    private var workouts: [Workout] = []
    private var didCollectionViewLayedout = false
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureWorkoutsData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Home Workouts"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard didCollectionViewLayedout == false else { return }
        didCollectionViewLayedout = true
        setupCollectionView()
    }
    
}

// MARK:- Private Methods
extension HomeVC {
    private func setupViews() {
        setupNavigationController()
        setupFullBodyButton()
    }
    
    private func setupNavigationController() {
        title = "Home Workouts"
        navigationController?.navigationBar.prefersLargeTitles = true
        let menuItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .done, target: self, action: #selector(menuItemTapped))
        navigationItem.leftBarButtonItem = menuItem
    }
    
    @objc private func menuItemTapped() {
        let menuVC = UIStoryboard(name: "Menu", bundle: nil).instantiateViewController(identifier: "MenuVC") as! MenuVC
        let menuNav = SideMenuNavigationController(rootViewController: menuVC)
        menuNav.leftSide = true
        menuNav.blurEffectStyle = .prominent
        menuNav.presentationStyle = .menuSlideIn
        menuNav.presentationStyle.presentingEndAlpha = 0.4
        present(menuNav, animated: true, completion: nil)
    }
    
    private func setupFullBodyButton() {
        fullBodyButton.setImage(UIImage(named: "Full Body"), for: .normal)
        fullBodyButton.imageView?.contentMode = .scaleAspectFill
        fullBodyButton.layer.cornerRadius = fullBodyButton.frame.height / 14
        fullBodyButton.clipsToBounds = true
        fullBodyButton.addTarget(self, action: #selector(fullBodyTapped), for: .touchDown)
    }
    
    @objc private func fullBodyTapped() {
        let workoutsVC = UIStoryboard(name: "Workouts", bundle: nil).instantiateViewController(identifier: "WorkoutsVC") as! WorkoutsVC
        let homeWorkout = Workout(day: "Home Workouts", bodyPart: "Full Body", image: "Full Body", routine: ["Warm-up", "Bridges: 3x15", "Chair Squat: 4x12", "Bicycle Crunches: 4x12", "Push-ups: 5x25", "Hip Extentions: 3x10","Planks 30 seconds", "Jumping Jacks: 3x15" ,"Chin-ups: 3x10","Jumping Jacks: 4x15","SuperMans: 4x8","Squats: 5x10","Jumping Lunges: 4x10"])
        workoutsVC.workout = homeWorkout
        navigationController?.pushViewController(workoutsVC, animated: true)
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: "WeeklyPlanCell", bundle: nil), forCellWithReuseIdentifier: "WeeklyPlanCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.itemSize = CGSize(width: collectionView.frame.width / 1.78, height: collectionView.frame.height)
        print("VVV", collectionView.frame.width)
        layout.minimumInteritemSpacing = 60
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    private func configureWorkoutsData() {
        workouts = [
            Workout(day: "Monday", bodyPart: "Chest", image: "Chest", routine: ["Warm-up", "Bench Presses: 4x12", "Incline DumbBells: 4x8", "Smith Machine: 4x10", "Decline Barbell: 5x12", "Push-ups: 4x25", "Incline Cables: 5x12", "DumbBells Flyes: 4x12", "Cable Crossovers: 4x12", "Low Cable Flyes: 4x12", "Bent Forward Cable: 5x12","Chest Dip: 4x10","Pullover Bench: 4x12"]),

            //Tuesday's Workouts
            Workout(day: "Tuesday", bodyPart: "Arms", image: "Arms", routine: ["Warm-up", "DumbBells: 4x12", "Bicep Curls: 5x10","BarBell: 4x12 ","Cable Curls: 4x12", "Hammer Curls: 4x10","Close Grib: 4x8","Reverse Curls: 4x8", "Wide Grib Curls: 4x8","Dips: 4x10","Chin-ups: 4x12","EZ-Bar Curls: 4x15","OVer Head Curls: 5x12","Conventional Curl: 4x12","Face Pull: 6x8"]),

            //Wednesday's Workouts
            Workout(day: "Wednesday", bodyPart: "Back", image: "Back", routine: ["Stretch", "Pullups 5x12", "Lat Pull-Downs 4x12", "Deadlift 4x10","Bent-Over Rows: 4x10","Chin-Ups: 4x12","T-Bar Rows: 4z12","Seated Rows: 4x12","Weighted Pullup: 5x8","Romanian Deadlift: 4x12","Incline Dumbbell Rows: 6x10","Trap-Bar Deadlift: 5x8"]),

            //Thrusday's Workouts
            Workout(day: "Thrusday", bodyPart: "Legs", image: "Legs", routine: ["Squats 5x12", "Walking Lunges", "Leg Press 5x8", "Leg Extention 5x10","BarBell Squat: 5x10","Front Squats: 4x10","Sumo Deadlift: 4x8","Hack Squats: 4x10","Romanian Deadlift: 4x10","Front Squats: 5x8","Bulgarian Squat: 4x10","Leg Press: 5x8","Walking Lunges 4 times","Pasue Squats: 5sec "]),

            //Friday's Workouts
            Workout(day: "Friday", bodyPart: "Triceps", image: "Triceps", routine: ["Cables Rops: 4x10", "Lying Triceps Extencsions: 4x10","Tricep Dips: 4x8","Rope Pull Downs: 4x15", "Skull Crushers: 4x10", "Over Head Extentions: 4x12","Close Grib Bench: 4x10","Tricep Machine Dips: 4x8","Diamond Push-Ups: 3x15","Straight Arm Pull Downs: 3x12","Planks: 4x8"]),

            //Saturday's Workouts
            Workout(day: "Saturday", bodyPart: "Running", image: "Running", routine: ["Walking 45 mins", "Resting 10 mins","One Mile Run","Burpees: 3x10","Hiking: 30 mins","Treadmill: 30 mins each day","Stepping Machine: 25 mins","Butt Kicks: 2x10","High Knees: 2x5mins","Explosive hill sprints: 3x5mins","Short And Long Sprints: 6x8 sprints "]),

            //Sunday's Workouts
            Workout(day: "Sunday", bodyPart: "Rest", image: "Rest", routine: ["Full day of resting", "Drink Water","Eat Proper Meals", "Stretch","Foam Roll","Sleep 8 hours a day","Yoga","Massages","Light Workout","Protein meals","Little snacks"])
        ]
    }
}
// MARK:- CollectionView Delegate
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        workouts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeeklyPlanCell", for: indexPath) as! WeeklyPlanCell
        cell.configure(with: workouts[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let workoutsVC = UIStoryboard(name: "Workouts", bundle: nil).instantiateViewController(identifier: "WorkoutsVC") as! WorkoutsVC
        workoutsVC.workout = workouts[indexPath.item]
        navigationController?.pushViewController(workoutsVC, animated: true)
    }
}
