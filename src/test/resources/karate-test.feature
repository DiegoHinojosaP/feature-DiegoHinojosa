@PruebaHeroes
Feature: Test de API súper simple

Background:
  * def base_url = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/dihinojo/api'
  * configure ssl = true

  @id:1 @AgregarSuperHeroe
  Scenario: T-API-BTFAC-123-CA01- Agregar Personaje
    Given url base_url + '/characters'
    And def ingreso = read('classpath:../payloads/SuperHeroe.json')
    And request ingreso
    When method POST
    Then status 201
    And print response

  @id:2 @ConsultarSuperHeroe
  Scenario: T-API-BTFAC-123-CA02- Consultar Todos los Personajes
    * header content-type = 'application/json'
    Given url base_url + '/characters'
    When method GET
    Then status 200
    And print response

  @id:3 @ModificarSuperHeroe
  Scenario: T-API-BTFAC-123-CA03- Modificar Personaje por Id
    * def heroe = call read('karate-test.feature@ConsultarSuperHeroe')
    * print heroe
    * def heroeId = heroe.response[0].id
    * print heroeId
    Given url base_url + '/characters/' + heroeId
    And request { "name": "Diego", "alterego": "Tony Stark", "description": "Updated description", "powers": ["Armor", "Flight"] }
    When method PUT
    Then status 200

  @id:4 @EliminarSuperHeroe
  Scenario: T-API-BTFAC-123-CA04- Eliminar Personaje por Id
    * def heroe = call read('karate-test.feature@ConsultarSuperHeroe')
    * print heroe
    * def heroeId = heroe.response[0].id
    * print heroeId
    Given url base_url + '/characters/' + heroeId
    When method DELETE
    Then status 204

  @id:5 @ConsultarSuperHeroeId
  Scenario: T-API-BTFAC-123-CA05- Consultar Personaje por Id
    * def heroe = call read('karate-test.feature@ConsultarSuperHeroe')
    * print heroe
    * def heroeId = heroe.response[0].id
    * print heroeId
    Given url base_url + '/characters/' + heroeId
    When method GET
    Then status 200
    And print response

  @id:6 @ConsultarSuperHeroeIdError
  Scenario: T-API-BTFAC-123-CA06- Consultar Personaje no Existe
    * header content-type = 'application/json'
    Given url base_url + '/characters/'+ 999
    When method GET
    Then status 404
    And print response
