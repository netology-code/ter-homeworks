##Для 7 задания
locals{

    test_list = ["develop","stage","production"]

    test_map = {
        admin = "John"
        user  = "Alex"
    }

    servers = {
        develop = {
            cpu = 2
            ram = 4
            image = "ubuntu-21-10-x64"
            },
        stage = {
            cpu = 4
            ram = 8
            image = "ubuntu-20-04-x64"
            },
        production = {
            cpu = 10
            ram = 40
            image = "ubuntu-20-04-x64"
            }
    }

}

