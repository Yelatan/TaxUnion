//
//  MapViewController.swift
//  SidebarMenu
//
//  Created by Simon Ng on 2/2/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit
import SwiftyJSON
class ConsultingViewController: UIViewController, FlexibleTableViewDelegate {
    @IBOutlet weak var menuButton:UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = FlexibleTableView(frame: view.frame, delegate: self)
        view.backgroundColor = UIColor.redColor()
        view.addSubview(tableView)
        
        navigationItem.title = "Услуги для ИП";
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Скрыть все",
                                                            style:.Plain,
                                                            target:self,
                                                            action:#selector(ConsultingViewController.collapseSubrows))
        
        
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Camera, target: revealViewController(), action: #selector(addTapped))
        if revealViewController() != nil {
            
            menuButton.target = revealViewController()
            //            revealViewController().rearViewRevealWidth = 400
            menuButton.action = "revealToggle:"
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let contents = [
        [
            ["Регистрация фирм", "Открытие ИП","Получение Электронно–Цифровой подписи (ключ ЭЦП)", "Помощь в открытии юридического лица (для субъектов малого бизнеса)", "Помощь в открытии юридического лица (для субъектов среднего и крупного бизнеса)"],
            ["Ликвидация фирм", "Временное приостановление деятельности ИП", "Ликвидация деятельности ИП", "Ликвидация деятельности юридического лица", "Уничтожение печатей, штампов"],
            ["Обслуживание Кассовых аппаратов", "Регистрация ККМ на учет в УГД", "Продажа ККМ", "Продление книги учета наличных денег", "Заполнение журнала учета наличных денег", "Перерегистрация ККМ по другому адресу", "Расходные материалы для ККМ", "Снятие с учета ККМ", "Техническое обслуживание ККМ"],
            ["Бухгалтерское обслуживание", "Счет-фактуры, акты выполненных работ, накладные, платежные поручения", "Ведение бухгалтерского учета для ИП и ТОО"],
            ["Печати и штампы", "изготовление печатей, штампов", "Виды печатей и штампов", "Модель №3"],
            ["Полиграфия", "Визитки", "Фирменные бланки"],
            ["Налоговое обслуживание", "Изменение регистрационных данных ИП", "Получение дубликата свидетельства ИП", "Оформление/продление патента", "Получение справок о налоговых задолженностях", "Акты-сверок с налогового органа через кабинет НП", "Акты-сверок с налогового органа", "Представление интересов в Управлении гос.доходов", "Проверка Кабинета Налогоплательщика на наличие уведомлений (за 1 квартал)", "Подтверждение сопроводительных накладных СНА (за 1 мес)", "Сдача полугодовой отчет ФНО 910.00", "Квартальные отчеты", "Годовой отчет ФНО 700.00", "Отчетность по ввозу товара через страны Таможенного Союза", "Годовой отчет ФНО 220.00 (годовая)", "Годовой отчет ФНО 230.00 (гос.служба)", "Сдача годового отчета ФНО 851.00", "Сдача отчетности ФНО 710.00", "Подготовка документов для получения лицензии на розничную торговлю алкогольной продукцией"],
            ["Сейфы", "Сейфы металлические"]]
    ]
    
    var tableView: FlexibleTableView!
   
    func parseData(){
        let path: String = NSBundle.mainBundle().pathForResource("TaxUnion", ofType: "json") as! String!
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return contents.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents[section].count
    }
    
    func tableView(tableView: UITableView, numberOfSubRowsAtIndexPath indexPath: NSIndexPath) -> Int {
        return contents[indexPath.section][indexPath.row].count - 1;
    }
    
    func tableView(tableView: UITableView, shouldExpandSubRowsOfCellAtIndexPath indexPath: NSIndexPath) -> Bool {
        if (indexPath.section == 1 && indexPath.row == 0){
            return true
        }
        
        return false
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = FlexibleTableViewCell(style:.Default, reuseIdentifier:"cell")
        
        cell.textLabel!.text = contents[indexPath.section][indexPath.row][0]
        cell.expandable = true
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath)
        
        print("didSelectRowAtIndexPath", cell.textLabel?.text)
    }
    
    func tableView(tableView: FlexibleTableView, didSelectSubRowAtIndexPath indexPath: FlexibleIndexPath) {
        let cell = self.tableView(tableView, cellForSubRowAtIndexPath: indexPath)
        print("didSelectSubRowAtIndexPath", cell.textLabel?.text)
        
        let path: String = NSBundle.mainBundle().pathForResource("TaxUnion", ofType: "json") as! String!
        let jsonData = NSData(contentsOfFile: path) as! NSData!
        let readableJSON = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)
        
        var description = readableJSON[contents[indexPath.section][indexPath.row][0]][contents[indexPath.section][indexPath.row][indexPath.subRow]]["Description"]
        NSLog("\(description)")
        var price = readableJSON[contents[indexPath.section][indexPath.row][0]][contents[indexPath.section][indexPath.row][indexPath.subRow]]["Price"]
        NSLog("\(price)")
        
        var ConsWebCcontrollerView: ConsultingWebViewController//DetailMovieController!
        ConsWebCcontrollerView = (self.storyboard?.instantiateViewControllerWithIdentifier("ConsultingWebViewController")) as! ConsultingWebViewController;
        self.navigationController?.pushViewController(ConsWebCcontrollerView, animated: true)
        
        ConsWebCcontrollerView.priceText = "\(price)"
        ConsWebCcontrollerView.descriptionText = "\(description)"
       
        
        
    }
    
    
    
    func tableView(tableView: UITableView, cellForSubRowAtIndexPath indexPath: FlexibleIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:.Default, reuseIdentifier:"cell")
        cell.backgroundColor=UIColor.groupTableViewBackgroundColor()
        cell.textLabel!.text = contents[indexPath.section][indexPath.row][indexPath.subRow]
        return cell;
    }
    
    
    func collapseSubrows() {
        tableView.collapseCurrentlyExpandedIndexPaths()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }

}
