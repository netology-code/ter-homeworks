variable "env_name" {
  type    = string
  default = "develop"
}

variable "empty" {
  type    = string
  default = ""
}

locals {
  test_list = ["develop", "staging", "production"]

  test = [
    {
      "dev1" = [
        "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117",
        "10.0.1.7",
      ]
    },
    {
      "dev2" = [
        "ssh -o 'StrictHostKeyChecking=no' ubuntu@84.252.140.88",
        "10.0.2.29",
      ]
    },
    {
      "prod1" = [
        "ssh -o 'StrictHostKeyChecking=no' ubuntu@51.250.2.101",
        "10.0.1.30",
      ]
    },
  ]


}


#1. Часто используемые функции

#> join( ",", ["Hello ", "world ", "!" ] ) 

#> split( ",", "HELLO,THERE" )

#> type("a")
#> type([1,2,"a"])

#> concat( [ 1,2,3 ], [ 4,5,6 ] )

#> type(tolist( [ 1,2,3 ]) )
#> type(tolist([true, false]))
#> type(tolist( [ true,2,3,"a" ]) )
#> type(local.test)

#> merge( { "1": "A ","2": "B" }, { "3": "C", "4": "D" } )


#> flatten( [  ["1", "2" , [["1"],"Q","W"]]  ,   [ "3","4", ["E","R"]]   ] )

#>  slice([  "ru-central1-a",  "ru-central1-b",  "ru-central1-c",  "ru-central1-d",],0,3)


#> coalesce("", var.empty, 1, "a")
#> coalesce("", var.empty, "a", 1)
#> coalesce("", var.empty)

#> contains(tolist(["q","w","e"]), "w")
#> contains(tolist(["q","e"]), "w")

#> try(local.test_list[2], "develop")
#> try(local.test_list[9], "develop")


#> abspath(path.module)
#> basename(abspath(path.module))

#> range(1, 4, 0.5)


#2. Условные выражения


#> var.env_name == "production" ? 3 : 1
#> var.env_name == "develop" ? 0 : 1

#3. for

#> [ for a in  local.test_list : upper(a) ]
#> [for a in  local.test_list : upper(a) if a !="production"]

#4. templatefile
