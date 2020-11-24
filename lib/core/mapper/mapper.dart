abstract class Mapper<Entity, Domain> {
  Entity to(Domain domain);

  Domain from(Entity entity);
}
