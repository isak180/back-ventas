# Backend Ventas - Spring Boot | ISY1101 EP2

API REST para gestión de ventas con **Spring Boot + Java 21 + MySQL**, dockerizada y desplegada en AWS EC2 mediante CI/CD.

---

## Estructura

```
backend-ventas/
├── Springboot-API-REST/            # Código fuente
├── Dockerfile                       # Multi-stage build
├── docker-compose.yml               # Stack: Spring Boot + MySQL
├── init.sql                         # Inicialización BD
├── .env.example
└── .github/workflows/
    └── cicd-backend-ventas.yml
```

---

## Ejecución local

```bash
cp .env.example .env
docker-compose up -d --build
```

API disponible en: `http://localhost:8081`

---

## Endpoints principales

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| GET | `/api/ventas` | Listar ventas |
| GET | `/api/ventas/{id}` | Obtener venta |
| POST | `/api/ventas` | Crear venta |
| PUT | `/api/ventas/{id}` | Actualizar venta |
| DELETE | `/api/ventas/{id}` | Eliminar venta |

---

## Persistencia

Named volume `ventas-db-data` para MySQL. Ver justificación en README del backend-despachos.

---

## GitHub Secrets requeridos

Los mismos que backend-despachos más:
- `ECR_REPO_BACKEND_VENTAS`
- `DB_NAME_VENTAS`
