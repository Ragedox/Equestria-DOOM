/* Copyright Alexander 'm8f' Kromm (mmaulwurff@gmail.com) 2021
 *
 * This file is a part of Typist.pk3.
 *
 * Typist.pk3 is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later
 * version.
 *
 * Typist.pk3 is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
 * A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * Typist.pk3.  If not, see <https://www.gnu.org/licenses/>.
 */

class ia_EventHandler : EventHandler
{

  override
  void worldLoaded(WorldEvent event)
  {
    mIsImpDied = false;
  }

  override
  void worldUnloaded(WorldEvent event)
  {
    if (isImpsPresent() && !mIsImpDied)
    {
      sa_Achiever.achieve("ia_Friend");
    }
  }

  override
  void worldThingDied(WorldEvent event)
  {
    if (isImp(event.thing))
    {
      mIsImpDied = true;
    }
  }

  private
  bool isImp(Actor a)
  {
    bool isReplacingImp = ("DoomImp" == Actor.getReplacee(a.getClass()));
    bool isBasedOnImp   = (a is "DoomImp");
    return (isReplacingImp || isBasedOnImp);
  }

  private
  bool isImpsPresent()
  {
    let i = ThinkerIterator.create();
    Actor a;
    while (a = Actor(i.next()))
    {
      if (isImp(a)) return true;
    }
    return false;
  }

  private bool mIsImpDied;

} // class ia_EventHandler

class ia_Friend : sa_Achievement
{
  Default
  {
    sa_Achievement.name "Imp Friend";
    sa_Achievement.description "Don't kill any imp on the level";
    sa_Achievement.borderColor 0x000000;
    sa_Achievement.boxColor    0x00AA00;
    sa_Achievement.lockedIcon "Graphics/Achievements/sa_icon.png";
    sa_Achievement.unlockedIcon "Graphics/Achievements/sa_icon.png";
  }
}