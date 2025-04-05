
resource "azurerm_cosmosdb_account" "main" {
  name                      = "${var.resource_name_prefix}-cosmosdb"
  location                  = var.location
  resource_group_name       = var.resource_group_name
  offer_type                = "Standard"
  kind                      = "GlobalDocumentDB"
  automatic_failover_enabled = false
  free_tier_enabled          = true
  capacity {
    total_throughput_limit = var.throughput
  }

  
  geo_location {
    location          = var.location
    failover_priority = 0
  }
  
  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  
  tags = var.tags
}

resource "azurerm_cosmosdb_sql_database" "main" {
  name                = "${var.resource_name_prefix}-cosmosdb-sqldb"
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.main.name
  throughput = var.throughput
}

resource "azurerm_cosmosdb_sql_container" "company" {
  name                  = "company"
  resource_group_name = var.resource_group_name
  account_name          = azurerm_cosmosdb_account.main.name
  database_name         = azurerm_cosmosdb_sql_database.main.name
  partition_key_version = 2
  partition_key_kind = "MultiHash"
  partition_key_paths = ["/id"]

  indexing_policy {
    indexing_mode = "consistent"

    included_path {
      path = "/*"
    }

    excluded_path {
      path = "/address_line2/?"
    }

    excluded_path {
      path = "/address_line3/?"
    }
  }

  unique_key {
    paths = ["/email"]
  }
}

resource "azurerm_cosmosdb_sql_container" "user" {
  name                  = "user"
  resource_group_name = var.resource_group_name
  account_name          = azurerm_cosmosdb_account.main.name
  database_name         = azurerm_cosmosdb_sql_database.main.name
  partition_key_version = 2
  partition_key_kind = "MultiHash"
  partition_key_paths = ["/companyId","/id"]

  indexing_policy {
    indexing_mode = "consistent"

    included_path {
      path = "/*"
    }

  }

}

resource "azurerm_cosmosdb_sql_container" "event" {
  name                  = "event"
  resource_group_name = var.resource_group_name
  account_name          = azurerm_cosmosdb_account.main.name
  database_name         = azurerm_cosmosdb_sql_database.main.name
  partition_key_version = 2
  partition_key_kind = "MultiHash"
  partition_key_paths = ["/companyId","/id"]

  indexing_policy {
    indexing_mode = "consistent"

    included_path {
      path = "/*"
    }
  }

}

resource "azurerm_cosmosdb_sql_container" "pass" {
  name                  = "pass"
  resource_group_name = var.resource_group_name
  account_name          = azurerm_cosmosdb_account.main.name
  database_name         = azurerm_cosmosdb_sql_database.main.name
  partition_key_version = 2
  partition_key_kind = "MultiHash"
  partition_key_paths = ["/companyId","/eventId","/id"]

  indexing_policy {
    indexing_mode = "consistent"

    included_path {
      path = "/*"
    }

  }

}


resource "azurerm_cosmosdb_sql_container" "role" {
  name                  = "role"
  resource_group_name = var.resource_group_name
  account_name          = azurerm_cosmosdb_account.main.name
  database_name         = azurerm_cosmosdb_sql_database.main.name
  partition_key_version = 2
  partition_key_kind = "MultiHash"
  partition_key_paths = ["/id"]

  indexing_policy {
    indexing_mode = "consistent"

    included_path {
      path = "/*"
    }

  }
}
