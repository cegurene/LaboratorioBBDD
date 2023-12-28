
import sys
import psycopg2

class portException(Exception): pass


def ask_conn_parameters():
    """
        pide los parámetros de conexión
    """
    print('Se va a intentar conectar a la base de datos.')
    host = 'localhost'                                                          
    port = 5432                                       
    user = 'postgres'
    password = input('Password: ')                                                               
    database = 'postgres'                                                               
    return (host, port, user, password, database)

def ask_query():
    return input("Query: ")

def ask_user():
    usuario = input('Usuario: ')
    contrasenna = input('Password: ')
    return (usuario, contrasenna)


def main():
    """
        main :: () -> IO None
    """
    try:

        (host, port, user, password, database) = ask_conn_parameters()          
        connstring = f"host={host} port={port} user={user} password={password} dbname={database} options='-c search_path=cine'"
        conn = psycopg2.connect(connstring)
        cur = conn.cursor()
        print('Se ha conectado a la base de datos correctamente.')


        query = ask_query()  
        cur.execute(query)

        for record in cur.fetchall():                                           # fetchall devuelve todas las filas de la consulta
            print(record)

        cur.close  
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
