# CICLO DE VIDA TERRAFORM

```bash
# INIT: DEFINO UN ESPACIO DE TRABAJO
terraform init

# PLAN: VALIDO QUE CAMBIOS SE REALIZARÁN DENTRO DE LA INFRA QUE VOY A APROVISIONAR
terraform plan

# APPLY: EJECUTO/APLICO TODO LO QUE EN EL TEST-PLAN SE HA EVIDENCIADO QUE APLICARÁ
terraform apply

# DESTROY: ELIMINARÁ TODO LO CONSTRUIDO
terraform destroy
```
<br/>


# AWS
Crear usuario en aws para el uso de cli con terraform
- nombre de usuario: terraform
- tipo de acceso: cli (mediante programacion)
- `siguiente permisos`

Establecer permisos: Asociar directamente las politicas existentes
- check: AdministratrorAccess
- `siguienteas etiquetas`
- `siguiente revisar`
- `crear usuario`

Copiamos ID clave de acceso y clave de acceso secreta, serán usados en Jenkins para la ejecución con terraform

Creamos el security group en aws console
- nombre de grupo de seguridad: ssh-access
- descripcion: ssh-access
- vpc: default

Reglas de entrada
- ss: 22     CUALQUIER ORIGEN 
- `guardamos`

Crear par de claves
- nombre: terraform-keypair
- formato de archivo: pem
- `crear clave privada (guardamos en lugar seguro)`

El security group creado tiene un identificador, lo copiamos (sg-0d5a6XXXXX)
<br/>
<br/>

# JENKINSFILE
Creamos un repositorio y subimos todo el código, no olvidar .gitignore DE terraform.

Creamos un proyecto jenkins de tipo pipeline, indicamos repositorio y ejecutamos.
<br/>
<br/>

# TERRAFORM FILES
```python
# TIPO_RECURSO, NOMBRE_INSTANCIA_AWS
resource "aws_instance" "linux_frodas" { 
    # CODIGO DE LA AMI
    ami = "ami-07dd19a7900a1f049"

    # LA CARACTERISTICA COMO MEMORIA Y PROCESADOR
    instance_type = "t3.micro"

    # CLAVE PRIVADA PARA ACCEDER POR SSH AL RECURSO CREADO
    key_name = "terraform-keypair"

    # PERMISOS PARA PODER ACCEDER A LA INSTANCIA, PORT 22
    vpc_security_group_ids = ["sg-0d5a6XXXXX"]
    tags = { 
        Name = "Linux"
    }
}

# INSTANCIA WINDOWS
resource "aws_instance" "windows_frodas" {
    ami = "ami-0sdxxxxxxxxx"
    instance_type = "t3.micro"
    tags = { 
        Name = "Windows"
    }
}
```
<br/>
<br/>


# TERRAFORM INIT
Al ejecutar el comando
```bash
terraform init 
```
Terraform detecta este archivo, aprovisionará los complementos necesarios.
<br />
Para poder trabajar con aws, los parámetros los pasaremos por jenkins.
<br />

