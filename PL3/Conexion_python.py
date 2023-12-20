
import sys
import psycopg2

class portException(Exception): pass


def ask_conn_parameters():
    """
        ask_conn_parameters:: () -> IO String
        pide los parámetros de conexión
        TODO: cada estudiante debe introducir los valores para su base de datos
    """
    host = 'localhost'                                                          
    port = 5432                                       
    user = input('User: ')                                                                   
    password = input('Password: ')                                                               
    database = ''                                                               
    return (host, port, user, password, database)


def main():
    """
        main :: () -> IO None
    """
    try:

        resultado = False

        while resultado == False:
            (host, port, user, password, database) = ask_conn_parameters()          
            connstring = f'host={host} port={port} user={user} password={password} dbname={database}' 
            
            cur = conn.cursor()

            cur.execute("USE cine")
            cur.execute("SELECT user FROM mysql.user WHERE user = %s AND authentication_string = PASSWORD(%s)", (user, password))
            resultado = cur.fetchone()
            if resultado == True:
                print("¡Credenciales válidas! Acceso concedido.")
            else:
                print("Credenciales incorrectas. Acceso denegado.")
                cur.close                                                       # cierra el cursor
        
        conn    = psycopg2.connect(connstring)
        query   = 'SELECT * FROM películas.final'                               # cambiar la query para cada consulta diferente  
        cur.execute(query)                                                      # ejecuta la consulta
        for record in cur.fetchall():                                           # fetchall devuelve todas las filas de la consulta
            print(record)                                                       # imprime las filas   
        conn.close                                                              # cierra la conexion
    except portException:
        print("The port is not valid!")
    except KeyboardInterrupt:
        print("Program interrupted by user.")
    finally:
        print("Program finished")

if __name__ == "__main__":                                                      # Es el modula principal?
    if '--test' in sys.argv:                                                    # chequea el argumento cmdline buscando el modo test
        import doctest                                                          # importa la libreria doctest
        doctest.testmod()                                                       # corre los tests
    else:                                                                       # else
        main()                                                                  # ejecuta el programa principal
