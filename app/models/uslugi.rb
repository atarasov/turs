class Uslugi < ActiveRecord::Base
  belongs_to :user

  #TO_AGENCY
  TO_OPERATOR=[:consalt => 1,
               :turs => 2,
               :viza => 3,
               :bron=> 4,
               :pasport=> 5,
               :doc => 6,
               :kredit => 7,
               :sertif => 8,
               :priem => 9]

  #TO_RECREATION
  TO_SANATORIUM=[:consalt => 1,
               :projiv => 2,
               :lechenie => 3,
               :pitanie=> 4,
               :exkurs=> 5,
               :koncert => 6,
               :bassein => 7,
               :sauna => 8,
               :banya => 9,
               :bilyard => 10,
               :programma => 11]

  TO_HOSTEL=[:consalt => 1,
               :projiv => 2,
               :lechenie => 3,
               :wifi=> 4,
               :exkurs=> 5,
               :koncert => 6,
               :bassein => 7,
               :sauna => 8,
               :banya => 9,
               :bilyard => 10,
               :programma => 11]
  #TO_MINI_HOTEL
  #TO_HOTEL

  TO_GUIDE=[:consalt => 1,
               :vstrechaet => 2,
               :razmeshenie => 3,
               :perevod=> 4,
               :exkurs=> 5,
               :soprovog => 6,
               :doc => 7]

  TO_TAXI=[:consalt => 1,
               :vair => 2,
               :izair => 3,
               :help=> 4,
               :zakaz=> 5]

  
  #TO_AGENCY_NAME
  TO_OPERATOR_NAME=[[1=>"Консультация"],
                      [2=>"Продажа туров"],
                      [3=>"Оформление визы"],
                      [4=>"Бронирование билетов"],
                      [5=>"Оформление паспорта"],
                      [6=>"Страхование туристов"],
                      [7=>"Тры в кредит"],
                      [8=>"Подарочные сертификаты"],
                      [9=>"Услуги принимающей стороны"]]

  #TO_RECREATION_NAME
  TO_SANATORIUM_NAME=[[1=>"Консультация"],
                      [2=>"Проживание"],
                      [3=>"Лечение"],
                      [4=>"питание"],
                      [5=>"Экскурсии"],
                      [6=>"Концерты"],
                      [7=>"Бассеин"],
                      [8=>"Сауна"],
                      [9=>"Баня"],
                      [10=>"Бильярд"],
                      [11=>"Развлекательные программы"]]


  TO_GUIDE_NAME={"Консультация" =>1,
                      "Встреча" =>2,
                      "Размещение" =>3,
                      "Переводчик" =>4,
                      "Экскурсии" =>5,
                      "Сопровождение" =>6,
                      "Оформление документов"=>7}

  TO_GUIDE_NAME2=   {1=>"Консультация" ,
                      2 =>"Встреча" ,
                      3 =>"Размещение",
                      4 => "Переводчик",
                      5 =>"Экскурсии",
                      6 =>"Сопровождение",
                      7=>"Оформление документов"}

  #TO_MINI_HOTEL_NAME
  #TO_HOTEL_NAME
  TO_HOSTEL_NAME=[[1=>"Консультация"],
                      [2=>"Проживание"],
                      [3=>"Wi-Fi интернет"],
                      [4=>"питание"],
                      [5=>"Экскурсии"],
                      [6=>"Концерты"],
                      [7=>"Бассеин"],
                      [8=>"Сауна"],
                      [9=>"Баня"],
                      [10=>"Бильярд"],
                      [11=>"Развлекательные программы"]]

  TO_TAXI_NAME=[[1=>"Консультация"],
                      [2=>"Такси в аэропорт"],
                      [3=>"Такси из аэропорта"],
                      [4=>"Помощь с вещами "],
                      [5=>"Предварительный заказ"]]




end
